#!/usr/bin/env bash
# ---------------------------------------------------------------
# Файл: scripts/publish.sh
# Назначение: Подготовка релиза KBFix (проверки + тег + push; GitHub Release создаётся CI).
# CI: .github/workflows/release.yml — создаёт GitHub Release по push тега vX.Y.Z и прикрепляет .deb.
#
# Скрипт рассчитан на открытый open-source поток:
#  - работает через git-теги вида v0.1.0
#  - собирает .deb через dpkg-buildpackage
#  - пушит ветку и теги
#  - создаёт git-тег и пушит его (GitHub Release автоматически создаётся GitHub Actions)
#
# Важно:
#  - НИЧЕГО не делает "молча": на каждом важном шаге просит подтверждение.
#  - Не коммитит автоматически "мусор" сборки (debian/* artifacts) — они должны быть в .gitignore.
#  - Предполагается, что debian/* (control/changelog/install/rules/postinst/postrm) уже в репо.
# ---------------------------------------------------------------

set -euo pipefail

# ----------------------------
# Утилиты вывода
# ----------------------------
info()  { echo -e "✅ $*"; }
warn()  { echo -e "⚠️  $*" >&2; }
err()   { echo -e "❌ $*" >&2; exit 1; }

pkg_name="kbfix"

print_sync_status() {
  # $1 = branch
  local branch="$1"
  local upstream="origin/${branch}"
  echo
  info "Текущая ветка: ${branch}"
  if ! git show-ref --verify --quiet "refs/remotes/${upstream}"; then
    warn "Upstream не найден: ${upstream}. Синхронизация пропущена."
    return 1
  fi
  echo "Upstream: ${upstream}"
  local counts
  counts="$(git rev-list --left-right --count "${upstream}...HEAD")"
  SYNC_BEHIND="${counts%% *}"
  SYNC_AHEAD="${counts##* }"
  echo "Статус: behind=${SYNC_BEHIND}, ahead=${SYNC_AHEAD}"
  return 0
}

ask_yes_no() {
  # $1 = вопрос
  local q="$1"
  read -r -p "${q} [y/N]: " ans
  ans="${ans//[[:space:]]/}"
  [[ "${ans:-}" =~ ^([Yy]|[Yy][Ee][Ss])$ ]]
}

ask_yes_no_default_yes() {
  # $1 = вопрос
  local q="$1"
  read -r -p "${q} [Y/n]: " ans
  ans="${ans//[[:space:]]/}"
  [[ -z "${ans:-}" || "${ans}" =~ ^([Yy]|[Yy][Ee][Ss])$ ]]
}

get_latest_release_tag() {
  git tag --list "v*" \
    | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' \
    | sort -V \
    | tail -n 1
}

bump_semver() {
  local ver="$1"
  local bump="$2"
  local major minor patch
  IFS='.' read -r major minor patch <<< "$ver"
  major="${major:-0}"
  minor="${minor:-0}"
  patch="${patch:-0}"
  case "$bump" in
    patch)
      patch=$((patch + 1))
      ;;
    minor)
      minor=$((minor + 1))
      patch=0
      ;;
    major)
      major=$((major + 1))
      minor=0
      patch=0
      ;;
    *)
      err "Неизвестный тип bump: ${bump}"
      ;;
  esac
  printf "%s.%s.%s" "$major" "$minor" "$patch"
}

next_prerelease_num() {
  local base_ver="$1"
  local pre="$2"
  local max=0
  local t n
  while read -r t; do
    n="${t#v${base_ver}-${pre}.}"
    if [[ "$n" =~ ^[0-9]+$ ]]; then
      if (( n > max )); then
        max=$n
      fi
    fi
  done < <(git tag --list "v${base_ver}-${pre}.*")
  printf "%d" $((max + 1))
}

derive_deb_version() {
  local ver="$1"
  if [[ "$ver" =~ ^([0-9]+\.[0-9]+\.[0-9]+)-((rc|beta|alpha)\.[0-9]+)$ ]]; then
    local base="${BASH_REMATCH[1]}"
    local pre="${BASH_REMATCH[2]}"
    local pre_type="${pre%.*}"
    local pre_num="${pre#*.}"
    printf "%s~%s%s-1" "$base" "$pre_type" "$pre_num"
  else
    printf "%s-1" "$ver"
  fi
}

ensure_changelog_section() {
  local ver="$1"
  local file="CHANGELOG.md"
  local section tmp insert_line insert_mode
  [[ -f "$file" ]] || err "Не найден CHANGELOG.md"

  if grep -qE "^## \\[${ver}\\]" "$file"; then
    info "CHANGELOG.md содержит секцию: ## [${ver}]"
    return 0
  fi

  section="$(printf "## [%s]\n- ...\n\n" "$ver")"
  tmp="$(mktemp)"

  insert_mode="$(awk '
    BEGIN {fs_line=0; unreleased=0; end_line=0; line=0;}
    {
      line++
      if (fs_line==0 && $0 ~ /^## \[/) {
        fs_line=line
        if ($0 ~ /^## \[Unreleased\]/) unreleased=1
      } else if (fs_line>0 && unreleased && end_line==0 && $0 ~ /^## \[/) {
        end_line=line-1
      }
    }
    END {
      if (fs_line==0) {
        print "none"
      } else if (unreleased) {
        if (end_line==0) end_line=line
        print "after:" end_line
      } else {
        print "before:" fs_line
      }
    }
  ' "$file")"

  if [[ "$insert_mode" == "none" ]]; then
    cat "$file" > "$tmp"
    printf "%s" "$section" >> "$tmp"
  elif [[ "$insert_mode" == before:* ]]; then
    insert_line="${insert_mode#before:}"
    awk -v insert_line="$insert_line" -v section="$section" '
      NR==insert_line {printf "%s", section}
      {print}
    ' "$file" > "$tmp"
  else
    insert_line="${insert_mode#after:}"
    awk -v insert_line="$insert_line" -v section="$section" '
      {print}
      NR==insert_line {printf "%s", section}
    ' "$file" > "$tmp"
  fi

  mv "$tmp" "$file"
  info "Добавлена секция в CHANGELOG.md: ## [${ver}]"
}

generate_release_notes() {
  local file="CHANGELOG.md"
  awk -v ver="$ver" '
    BEGIN {in_sec=0; sec=""; added=""; changed=""; fixed=""; found=0;}
    $0 ~ "^## \\[" ver "\\]" {in_sec=1; found=1; next}
    in_sec && /^## \\[/ { exit }
    in_sec {
      if ($0 ~ /^### Added/) { sec="added"; next }
      if ($0 ~ /^### Changed/) { sec="changed"; next }
      if ($0 ~ /^### Fixed/) { sec="fixed"; next }
      if ($0 ~ /^### /) { sec=""; next }
      if (sec=="added") { added = added $0 "\n" }
      else if (sec=="changed") { changed = changed $0 "\n" }
      else if (sec=="fixed") { fixed = fixed $0 "\n" }
    }
    END {
      if (!found) { exit 2 }
      if (added=="" && changed=="" && fixed=="") { exit 3 }
      print "## v" ver
      if (added!="") { print ""; print "### Added"; printf "%s", added }
      if (changed!="") { print ""; print "### Changed"; printf "%s", changed }
      if (fixed!="") { print ""; print "### Fixed"; printf "%s", fixed }
    }
  ' "$file"
}

# ----------------------------
# Переход в корень репозитория
# ----------------------------
repo_root="$(git rev-parse --show-toplevel 2>/dev/null)" || err "Не похоже на git-репозиторий."
cd "$repo_root"

# ----------------------------
# Этапы
# ----------------------------
select_branch_for_publish() {
  branch="$(git rev-parse --abbrev-ref HEAD)"
  if [[ "$branch" == "HEAD" ]]; then
    err "Detached HEAD. Переключись на ветку (например, main) и повтори."
  fi

  echo
  info "Текущая ветка: $branch"
  if ! ask_yes_no "Публиковать из ветки ${branch}? (y = использовать эту ветку, Enter = ввести другую)"; then
    read -r -p "Введите имя ветки: " new_branch
    [[ -n "${new_branch:-}" ]] || err "Имя ветки не задано."
    if git show-ref --verify --quiet refs/heads/"$new_branch"; then
      git checkout "$new_branch"
    elif git show-ref --verify --quiet "refs/remotes/origin/${new_branch}"; then
      git checkout -b "$new_branch" "origin/$new_branch"
    else
      err "Ветка ${new_branch} не существует ни локально, ни в origin."
    fi
    branch="$new_branch"
    info "Переключились на ветку: $branch"
  fi
  echo
}

ensure_clean_or_saved_worktree() {
  if [[ -n "$(git status --porcelain)" ]]; then
    warn "Есть незакоммиченные изменения (staged/unstaged/untracked)."
    echo "Статус git (porcelain):"
    git status --porcelain
    echo
    while true; do
      echo "Выбери безопасное действие:"
      echo " [1] Закоммитить ВСЁ (git add -A) с фикс-сообщением"
      echo " [2] Закоммитить ВСЁ (git add -A) с моим сообщением"
      echo " [3] Увести изменения в stash (сохраняет untracked)"
      echo " [4] Показать diff (unstaged и staged)"
      echo " [Enter] Отменить publish"
      echo -n "Выбор: "
      read -r choice
      if [[ -z "${choice:-}" ]]; then
        err "Публикация отменена пользователем."
      elif [[ "$choice" == "1" ]]; then
        git add -A
        if git diff --cached --quiet; then
          warn "Нет staged изменений. Возможно, есть только ignored файлы. Выбери другое действие."
          continue
        fi
        git commit -m "chore: prepare publish"
        info "Изменения закоммичены"
        break
      elif [[ "$choice" == "2" ]]; then
        read -r -p "Сообщение коммита: " message
        if [[ -z "${message:-}" ]]; then
          warn "Сообщение коммита не задано."
          continue
        fi
        git add -A
        if git diff --cached --quiet; then
          warn "Нет staged изменений. Возможно, есть только ignored файлы. Выбери другое действие."
          continue
        fi
        git commit -m "$message"
        info "Изменения закоммичены с пользовательским сообщением"
        break
      elif [[ "$choice" == "3" ]]; then
        stash_msg="publish.sh: $(date '+%Y-%m-%d %H:%M:%S')"
        git stash push -u -m "$stash_msg"
        info "Stash создан: $(git stash list | head -n 1)"
        break
      elif [[ "$choice" == "4" ]]; then
        echo
        info "Diff (unstaged):"
        git diff || true
        echo
        info "Diff (staged):"
        git diff --cached || true
        echo
        continue
      else
        warn "Неизвестный выбор. Повтори ввод."
        continue
      fi
    done
  fi
}

sync_with_origin_safely() {
  git remote get-url origin >/dev/null 2>&1 || err "Не настроен remote origin."
  git fetch --tags origin
  info "Теги обновлены: origin"
  SKIP_SYNC="no"
  if git ls-remote --exit-code --heads origin "${branch}" >/dev/null 2>&1; then
    git fetch origin "${branch}"
    info "Ветка обновлена из origin/${branch}"
  else
    warn "В origin нет ветки ${branch}. Синхронизация пропущена."
    SKIP_SYNC="yes"
  fi

  while true; do
    if [[ "$SKIP_SYNC" == "yes" ]]; then
      break
    fi
    if ! print_sync_status "$branch"; then
      break
    fi
    if [[ "${SYNC_BEHIND}" == "0" && "${SYNC_AHEAD}" == "0" ]]; then
      info "Ветка уже синхронизирована с origin/${branch}"
      break
    fi
    if [[ "${SYNC_BEHIND}" != "0" && "${SYNC_AHEAD}" == "0" ]]; then
      info "Рекомендация: [1] fast-forward (безопасно)"
    elif [[ "${SYNC_AHEAD}" != "0" && "${SYNC_BEHIND}" == "0" ]]; then
      warn "У вас локальные коммиты, которых нет в origin. Это нормально."
      info "Рекомендация: [3] пропустить синхронизацию (или позже сделать push ветки)."
    elif [[ "${SYNC_AHEAD}" != "0" && "${SYNC_BEHIND}" != "0" ]]; then
      warn "Ветки разошлись (есть коммиты и там, и тут)."
      info "Рекомендация: [2] rebase (создаст backup) или решить вручную."
    fi
    echo
    echo "Синхронизация с GitHub (origin/${branch}). Что делаем?"
    echo " [1] Обновить локальную ветку безопасно (fast-forward only)"
    echo " [2] Обновить через rebase (с резервной веткой)"
    echo " [3] Пропустить синхронизацию и продолжить"
    echo " [4] Показать изменения (commits ahead/behind)"
    echo " [Enter] Отменить publish"
    echo -n "Выбор: "
    read -r sync_choice
    if [[ -z "${sync_choice:-}" ]]; then
      err "Публикация отменена пользователем."
    elif [[ "$sync_choice" == "1" ]]; then
      if git merge --ff-only "origin/${branch}"; then
        info "Ветка обновлена fast-forward"
        break
      else
        warn "Нельзя fast-forward: у вас есть локальные коммиты или история разошлась."
        warn "Выберите [2] rebase или [3] пропустить синхронизацию."
        continue
      fi
    elif [[ "$sync_choice" == "2" ]]; then
      backup="backup/${branch}-$(date '+%Y%m%d-%H%M%S')"
      git branch "${backup}"
      info "Создана резервная ветка: ${backup}"
      if git rebase "origin/${branch}"; then
        info "Rebase завершён"
        break
      else
        warn "Rebase в процессе (конфликт)."
        warn "Чтобы отменить: git rebase --abort"
        warn "Чтобы посмотреть: git status"
        exit 1
      fi
    elif [[ "$sync_choice" == "3" ]]; then
      warn "Синхронизация пропущена"
      break
    elif [[ "$sync_choice" == "4" ]]; then
      echo
      info "Коммиты из origin (если behind):"
      git log --oneline "HEAD..origin/${branch}" || true
      echo
      info "Локальные коммиты (если ahead):"
      git log --oneline "origin/${branch}..HEAD" || true
      echo
      continue
    else
      warn "Неизвестный выбор. Повтори ввод."
      continue
    fi
  done
}

select_release_version() {
  release_enabled="yes"
  release_kind="release"
  tag_pushed="no"

  echo
  echo "Выбери тип релиза:"
  echo " [1] Релиз (X.Y.Z)"
  echo " [2] Пререлиз (X.Y.Z-rc.N / beta.N / alpha.N)"
  echo -n "Выбор [1]: "
  read -r release_choice
  if [[ -z "${release_choice:-}" || "$release_choice" == "1" ]]; then
    release_kind="release"
  elif [[ "$release_choice" == "2" ]]; then
    release_kind="prerelease"
  else
    err "Неизвестный выбор типа релиза."
  fi

  last_tag="$(get_latest_release_tag)"
  if [[ -z "${last_tag:-}" ]]; then
    last_ver="0.0.0"
    warn "Релизные теги не найдены. Базовая версия: ${last_ver}"
  else
    last_ver="${last_tag#v}"
    info "Последний релизный тег: ${last_tag}"
  fi

  if [[ "$release_kind" == "release" ]]; then
    read -r -p "Тип bump (patch/minor/major) [patch]: " bump
    bump="${bump:-patch}"
    auto_ver="$(bump_semver "$last_ver" "$bump")"
    read -r -p "Версия релиза [${auto_ver}]: " ver_input
    ver="${ver_input:-$auto_ver}"
    ver="${ver#v}"
    if [[ ! "$ver" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
      err "Некорректная версия релиза: ${ver}"
    fi
  else
    read -r -p "Тип bump базовой версии (patch/minor/major) [patch]: " bump
    bump="${bump:-patch}"
    read -r -p "Тип пререлиза (rc/beta/alpha) [rc]: " pre_type
    pre_type="${pre_type:-rc}"
    case "$pre_type" in
      rc|beta|alpha)
        ;;
      *)
        err "Неизвестный тип пререлиза: ${pre_type}"
        ;;
    esac
    base_ver="$(bump_semver "$last_ver" "$bump")"
    pre_num="$(next_prerelease_num "$base_ver" "$pre_type")"
    auto_ver="${base_ver}-${pre_type}.${pre_num}"
    read -r -p "Версия пререлиза [${auto_ver}]: " ver_input
    ver="${ver_input:-$auto_ver}"
    ver="${ver#v}"
    if [[ ! "$ver" =~ ^[0-9]+\.[0-9]+\.[0-9]+-(rc|beta|alpha)\.[0-9]+$ ]]; then
      err "Некорректная версия пререлиза: ${ver}"
    fi
  fi

  tag="v${ver}"
  deb_ver="$(derive_deb_version "$ver")"

  echo
  if [[ "$release_kind" == "prerelease" ]]; then
    info "Пререлиз: ${tag}"
  else
    info "Релиз: ${tag}"
  fi
  info "Debian version: ${deb_ver}"
  echo
}

prepare_release_commit() {
  # В debian/changelog должна быть первая строка вида:
  # kbfix (0.1.0-1) unstable; urgency=medium
  if [[ "$release_enabled" == "yes" ]]; then
    ensure_changelog_section "$ver"

    [[ -f "debian/changelog" ]] || err "Не найден debian/changelog"
    if ! command -v dch >/dev/null 2>&1; then
      err "Не найден dch (devscripts). Установи: sudo apt install devscripts"
    fi

    head_line="$(head -n 1 debian/changelog || true)"

    if [[ "$head_line" != "${pkg_name} (${deb_ver})"* ]]; then
      warn "debian/changelog сейчас: $head_line"
      warn "Ожидаем: ${pkg_name} (${deb_ver}) ..."
      dch --newversion "${deb_ver}" "Release ${tag}"
      info "debian/changelog обновлён через dch"
    else
      info "debian/changelog соответствует версии ${deb_ver}"
    fi

    echo
    info "Первые 5 строк debian/changelog:"
    head -n 5 debian/changelog || true
    echo

    wf_path=".github/workflows/release.yml"
    [[ -f "$wf_path" ]] || err "Не найден файл релизного workflow: ${wf_path}"
    if ! git ls-files --error-unmatch "$wf_path" >/dev/null 2>&1; then
      warn "Файл релизного workflow не отслеживается git — добавляю в коммит: ${wf_path}"
    fi

    git add -A -- "$wf_path" "CHANGELOG.md" "debian/changelog" "scripts/publish.sh"

    if git ls-files --others --exclude-standard -- "kbfix/dictionaries" | grep -q .; then
      if ask_yes_no_default_yes "Обнаружены untracked kbfix/dictionaries/. Добавить в коммит?"; then
        git add -A -- "kbfix/dictionaries"
        info "kbfix/dictionaries добавлены в коммит"
      else
        warn "kbfix/dictionaries останутся untracked"
      fi
    fi

    if git ls-files --others --exclude-standard -- "structure.md" | grep -q .; then
      if ask_yes_no_default_yes "Обнаружен untracked structure.md. Добавить в коммит?"; then
        git add -A -- "structure.md"
        info "structure.md добавлен в коммит"
      else
        warn "structure.md останется untracked"
      fi
    fi

    if ! git diff --cached --quiet; then
      git commit -m "chore: prepare release ${tag}"
      info "Коммит релиза создан"
    else
      warn "Нет изменений для коммита релиза"
    fi
  fi
}

build_deb() {
  build_done="no"
  echo
  if ask_yes_no "Собрать .deb пакет? (y = соберёт в ../, Enter = пропустит)"; then
    info "Запускаю сборку..."
    dpkg-buildpackage -us -uc
    build_done="yes"
    info "Сборка завершена"
  else
    warn "Сборка пропущена"
  fi
  if [[ "$release_enabled" == "no" && "$build_done" == "yes" ]]; then
    warn "Режим без релиза: сборка выполнена, артефакты находятся в родительской директории (../)."
    if ls -1 ../${pkg_name}_*.deb >/dev/null 2>&1; then
      ls -1 ../${pkg_name}_*.deb | head -n 5
    fi
    deb_file="$(ls -1 ../${pkg_name}_*.deb 2>/dev/null | head -n 1 || true)"
    if [[ -n "${deb_file:-}" && -f "${deb_file}" ]]; then
      info "Найден .deb: ${deb_file}"
    fi
  fi

  deb_file=""
  if [[ -n "${deb_ver:-}" ]]; then
    deb_expected="../${pkg_name}_${deb_ver}_all.deb"
    if [[ -f "$deb_expected" ]]; then
      deb_file="$deb_expected"
      info "Найден .deb: ${deb_file}"
    else
      deb_file="$(ls -1 ../${pkg_name}_${deb_ver}_*.deb 2>/dev/null | head -n 1 || true)"
      if [[ -n "${deb_file:-}" && -f "${deb_file}" ]]; then
        info "Найден .deb: ${deb_file}"
      else
        warn ".deb не найден: ${deb_expected}"
        warn "Если сборку пропустили — это нормально. Если собирали — проверь вывод dpkg-buildpackage."
      fi
    fi
  fi
}

create_tag() {
  if [[ "$release_enabled" == "yes" ]]; then
    if ! git diff --quiet || ! git diff --cached --quiet; then
      err "Рабочее дерево не чистое перед созданием тега."
    fi

    if git rev-parse -q --verify "refs/tags/${tag}" >/dev/null; then
      err "Тег ${tag} уже существует."
    fi
    if git ls-remote --tags origin "${tag}" | grep -q "refs/tags/${tag}$"; then
      err "Тег ${tag} уже существует в origin."
    fi

    if ! awk -v ver="$ver" '
      BEGIN {in_sec=0}
      $0 ~ "^## \\[" ver "\\]" {in_sec=1; next}
      in_sec && /^## \\[/ { exit 0 }
      in_sec && $0 ~ /^- \\.\\.\\./ { exit 1 }
      END { exit 0 }
    ' CHANGELOG.md; then
      err "CHANGELOG.md содержит placeholder, заполни release notes"
    fi

    echo
    wf_path=".github/workflows/release.yml"
    [[ -f "$wf_path" ]] || err "Не найден файл релизного workflow: ${wf_path}"
    git ls-files --error-unmatch "$wf_path" >/dev/null 2>&1 || err "Файл релизного workflow не отслеживается git: ${wf_path}"
    git show "HEAD:${wf_path}" >/dev/null 2>&1 || err "Файл релизного workflow отсутствует в HEAD: ${wf_path}"
    info "Release workflow присутствует и будет в теге: ${wf_path}"

    if ! grep -qE "^## \\[${ver}\\]" CHANGELOG.md; then
      err "В CHANGELOG.md нет секции '## [${ver}]'. Добавь её, иначе CI релиза упадёт."
    fi
    info "CHANGELOG.md содержит секцию: ## [${ver}]"

    local release_notes_tmp
    release_notes_tmp="$(mktemp)"
    trap 'rm -f "$release_notes_tmp"' RETURN
    if ! generate_release_notes > "$release_notes_tmp"; then
      err "Release notes пустые или не найдены для версии ${ver}."
    fi
    echo
    info "Preview release notes:"
    cat "$release_notes_tmp"
    echo
    if ! ask_yes_no "Использовать эти release notes?"; then
      info "Отменено пользователем."
      exit 0
    fi

    git tag -a "${tag}" -F "$release_notes_tmp"
    info "Тег создан: ${tag}"
  fi
}

push_branch_and_tag() {
  echo
  if [[ "$release_enabled" == "yes" ]]; then
    git push origin "${branch}"
    info "Ветка запушена: origin/${branch}"
    git push origin "${tag}"
    info "Тег релиза запушен: ${tag}"
    verify_github_release
    tag_pushed="yes"
  else
    if ask_yes_no "Отправить ветку ${branch} в GitHub? (y = отправит коммиты, Enter = пропустит)"; then
      git push origin "${branch}"
      info "Ветка запушена: origin/${branch}"
    else
      warn "Push ветки пропущен"
    fi
  fi

  if [[ "$release_enabled" == "yes" ]]; then
    if [[ "$tag_pushed" == "yes" ]]; then
      info "GitHub Release будет создан автоматически через GitHub Actions."
      info "Смотри: GitHub → Actions → workflow \"Release (.deb)\"."
      info "Релиз появится в разделе Releases и будет содержать .deb."
    else
      warn "Тег релиза не отправлен — CI релиз не запустится."
    fi
  fi

  echo
  info "Готово. Публикация завершена."
}

check_only_report() {
  echo
  branch_check="$(git rev-parse --abbrev-ref HEAD)"
  if [[ "$branch_check" == "HEAD" ]]; then
    warn "Detached HEAD."
  else
    info "Текущая ветка: ${branch_check}"
  fi
  echo "Статус git (porcelain):"
  git status --porcelain
  echo

  if git remote get-url origin >/dev/null 2>&1; then
    info "origin настроен"
  else
    warn "origin не настроен"
  fi

  git fetch --tags origin >/dev/null 2>&1 || true
  if [[ "$branch_check" != "HEAD" ]]; then
    git fetch origin "${branch_check}" >/dev/null 2>&1 || true
  fi

  if [[ "$branch_check" != "HEAD" ]]; then
    print_sync_status "$branch_check" || true
  fi

  last_tag_check="$(get_latest_release_tag)"
  if [[ -n "${last_tag_check:-}" ]]; then
    info "Последний релизный тег: ${last_tag_check}"
  else
    warn "Релизные теги не найдены."
  fi

  wf_path=".github/workflows/release.yml"
  if [[ -f "$wf_path" ]]; then
    info "Release workflow найден: ${wf_path}"
  else
    warn "Release workflow не найден: ${wf_path}"
  fi
}

verify_github_release() {
  if ! command -v gh >/dev/null 2>&1; then
    warn "gh CLI не установлен — пропускаю post-release проверку."
    return 0
  fi

  sleep 3

  local runs_json
  runs_json="$(gh run list --limit 5 --json databaseId,status,conclusion,name 2>/dev/null || true)"
  local match
  match="$(python3 - <<'PY'
import json
import sys

try:
    data = json.load(sys.stdin)
except Exception:
    data = []

for run in data:
    name = str(run.get("name", ""))
    if "Release" in name:
        print(f"{run.get('databaseId','')}\t{run.get('status','')}\t{run.get('conclusion','')}")
        break
PY
)"
  if [[ -n "${match}" ]]; then
    local run_id run_status run_conclusion
    run_id="${match%%$'\t'*}"
    run_status="${match#*$'\t'}"
    run_status="${run_status%%$'\t'*}"
    run_conclusion="${match##*$'\t'}"
    info "Release workflow detected:"
    echo "  id: ${run_id}"
    echo "  status: ${run_status}"
    echo "  conclusion: ${run_conclusion}"
  else
    warn "Release workflow не найден. Проверь GitHub → Actions вручную."
  fi
}

run_release() {
  select_branch_for_publish
  ensure_clean_or_saved_worktree
  sync_with_origin_safely
  select_release_version
  release_preview_and_confirm
  prepare_release_commit
  build_deb
  create_tag
  push_branch_and_tag
}

run_build_only() {
  echo
  info "Режим Build only: НЕ будет тегов, push, changelog. Только локальная сборка."
  echo
  release_enabled="no"
  release_kind=""
  tag_pushed="no"
  ver=""
  tag=""
  deb_ver=""
  select_branch_for_publish
  ensure_clean_or_saved_worktree
  build_deb
}

run_check_only() {
  check_only_report
}

run_dry_run() {
  select_branch_for_publish
  sync_with_origin_safely
  select_release_version
  release_preview_and_confirm

  local release_notes_tmp
  release_notes_tmp="$(mktemp)"
  if ! generate_release_notes > "$release_notes_tmp"; then
    rm -f "$release_notes_tmp"
    err "Release notes пустые или не найдены для версии ${ver}."
  fi
  echo
  info "Preview release notes:"
  cat "$release_notes_tmp"
  rm -f "$release_notes_tmp"
  echo
  info "Dry run завершён."
  exit 0
}

release_preview_and_confirm() {
  # Предпросмотр плана релиза перед изменениями
  local upstream="origin/${branch}"
  local behind_text="n/a"
  local ahead_text="n/a"
  if git show-ref --verify --quiet "refs/remotes/${upstream}"; then
    # Считаем статус здесь, чтобы preview всегда был точным (даже если sync пропустили)
    local counts
    counts="$(git rev-list --left-right --count "${upstream}...HEAD")"
    behind_text="${counts%% *}"
    ahead_text="${counts##* }"
  else
    upstream="n/a"
  fi

  echo
  info "PREVIEW"
  echo "Режим: Release"
  echo "Ветка: ${branch}"
  echo "Upstream: ${upstream}"
  echo "Статус: behind=${behind_text}, ahead=${ahead_text}"
  echo "Tag: ${tag}"
  echo "Debian version: ${deb_ver}"
  echo
  echo "Будут выполнены действия:"
  echo " 1) ensure_changelog_section + обновление debian/changelog через dch"
  echo " 2) git add + git commit (если есть изменения)"
  echo " 3) dpkg-buildpackage -us -uc (если пользователь согласится на сборку)"
  echo " 4) git tag -a ${tag}"
  echo " 5) git push origin ${branch}"
  echo " 6) git push origin ${tag}"
  echo
  if ! ask_yes_no "Продолжить выполнение релиза по этому плану?"; then
    info "Отменено пользователем."
    exit 0
  fi
}

# ----------------------------
# Главное меню
# ----------------------------
if [[ "${1:-}" == "--dry-run" ]]; then
  run_dry_run
fi

echo
echo "Режимы:"
echo " [1] Release (тег + push + GitHub Actions релиз)"
echo " [2] Build only (только сборка .deb локально)"
echo " [3] Check only (только проверки, без изменений)"
echo " [4] Dry run (показать план релиза, без изменений)"
echo " [Enter] Exit"
echo -n "Выбор: "
read -r mode_choice
if [[ -z "${mode_choice:-}" ]]; then
  exit 0
elif [[ "$mode_choice" == "1" ]]; then
  run_release
elif [[ "$mode_choice" == "2" ]]; then
  run_build_only
elif [[ "$mode_choice" == "3" ]]; then
  run_check_only
elif [[ "$mode_choice" == "4" ]]; then
  run_dry_run
else
  err "Неизвестный выбор режима."
fi
