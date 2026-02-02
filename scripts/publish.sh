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
  git tag --list "v[0-9]*.[0-9]*.[0-9]*" --sort=-v:refname | head -n 1
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

# ----------------------------
# Переход в корень репозитория
# ----------------------------
repo_root="$(git rev-parse --show-toplevel 2>/dev/null)" || err "Не похоже на git-репозиторий."
cd "$repo_root"

# ----------------------------
# Проверки git-состояния
# ----------------------------
branch="$(git rev-parse --abbrev-ref HEAD)"
if [[ "$branch" == "HEAD" ]]; then
  err "Detached HEAD. Переключись на ветку (например, main) и повтори."
fi

# Покажем статус и подтвердим ветку для публикации
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

# Проверка на незакоммиченные изменения
if ! git diff --quiet || ! git diff --cached --quiet; then
  warn "Есть незакоммиченные изменения."
  git status --porcelain
  echo
  while true; do
    echo "Выбери действие:"
    echo " [1] Автокоммитить изменения (фикс-сообщение)"
    echo " [2] Закоммитить изменения с моим сообщением"
    echo " [3] Откатить tracked и staged изменения"
    echo " [4] Очистка untracked файлов (git clean -ffd, ОПАСНО)"
    echo " [5] Удалит untracked и ignored файлы (даже если они в .gitignore)"
    echo " [Enter] Отменить publish"
    echo -n "Выбор действия: "
    read -r choice
    if [[ -z "${choice:-}" ]]; then
      err "Публикация отменена пользователем."
    elif [[ "$choice" == "1" ]]; then
      git add -A
      if git diff --cached --quiet; then
        warn "Нет staged изменений. Возможны только untracked файлы. Добавь их вручную или выбери другую опцию."
        continue
      fi
      git commit -m "chore: auto-commit before publish"
      info "Изменения закоммичены автоматически"
      break
    elif [[ "$choice" == "2" ]]; then
      read -r -p "Сообщение коммита: " message
      if [[ -z "${message:-}" ]]; then
        warn "Сообщение коммита не задано."
        continue
      fi
      git add -A
      if git diff --cached --quiet; then
        warn "Нет staged изменений. Возможны только untracked файлы. Добавь их вручную или выбери другую опцию."
        continue
      fi
      git commit -m "$message"
      info "Изменения закоммичены с пользовательским сообщением"
      break
    elif [[ "$choice" == "3" ]]; then
      echo "Сбросит изменения в tracked файлах. Введите YES:"
      read -r confirm
      if [[ "$confirm" == "YES" ]]; then
        git reset --hard
        warn "Изменения откатены"
        break
      else
        warn "Откат отменен"
        continue
      fi
    elif [[ "$choice" == "4" ]]; then
      echo "Удалит untracked файлы. Введите YES:"
      read -r confirm_clean
      if [[ "$confirm_clean" == "YES" ]]; then
        git clean -ffd
        warn "Выполнена очистка untracked файлов"
        break
      else
        warn "Очистка отменена"
        continue
      fi
    elif [[ "$choice" == "5" ]]; then
      echo "Удалит untracked и ignored файлы (даже если они в .gitignore). Введите YES:"
      read -r confirm_clean_all
      if [[ "$confirm_clean_all" == "YES" ]]; then
        git clean -ffdx
        warn "Выполнена полная очистка включая ignored"
        break
      else
        warn "Полная очистка отменена"
        continue
      fi
    else
      warn "Неизвестный выбор. Повтори ввод."
      continue
    fi
  done
fi

# ----------------------------
# Синхронизация с origin
# ----------------------------
git remote get-url origin >/dev/null 2>&1 || err "Не настроен remote origin."
if ask_yes_no "Обновить теги из GitHub? (y = скачает новые теги, Enter = пропустит)"; then
  git fetch --tags origin
  info "Обновление тегов выполнено"
else
  warn "fetch пропущен"
fi

if ask_yes_no "Обновить ветку ${branch} из GitHub с rebase? (y = подтянет и применит поверх, Enter = пропустит)"; then
  git pull --rebase origin "$branch"
  info "Обновление ветки выполнено"
else
  warn "pull --rebase пропущен"
fi

# ----------------------------
# Версия релиза
# ----------------------------
release_enabled="no"
release_kind="release"
tag_pushed="no"
if ask_yes_no "Выпускать релиз (тег + GitHub Release)? (y = выбрать тип/версию, Enter = без релиза)"; then
  release_enabled="yes"
fi

if [[ "$release_enabled" == "yes" ]]; then
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
else
  ver=""
  tag=""
  deb_ver=""
fi

echo
if [[ "$release_enabled" == "yes" ]]; then
  if [[ "$release_kind" == "prerelease" ]]; then
    info "Пререлиз: ${tag}"
  else
    info "Релиз: ${tag}"
  fi
  info "Debian version: ${deb_ver}"
else
  warn "Режим без релиза: теги и GitHub Release пропущены."
fi
echo

# ----------------------------
# Обновление/проверка CHANGELOG.md и debian/changelog
# ----------------------------
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
    # devscripts: корректно добавляет новую верхнюю запись
    dch --newversion "${deb_ver}" "Release ${tag}"
    info "debian/changelog обновлён через dch"
  else
    info "debian/changelog соответствует версии ${deb_ver}"
  fi

  # покажем верхушку для контроля
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

# ----------------------------
# Сборка .deb
# ----------------------------
build_done="no"
echo
if ask_yes_no "Собрать .deb пакет? (y = соберёт в ../, Enter = пропустит)"; then
  # Чистим старые артефакты именно сборки (не репозиторий!)
  # Важно: debian/ тут трогать нельзя, только ../*.deb и ../*.buildinfo и т.п.
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

# Ищем собранный .deb рядом (dpkg-buildpackage кладет в родительскую директорию)
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

# ----------------------------
# Создание git-тега
# ----------------------------
if [[ "$release_enabled" == "yes" ]]; then
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

  if git rev-parse -q --verify "refs/tags/${tag}" >/dev/null; then
    err "Тег ${tag} уже существует. Увеличь версию и запусти publish.sh снова."
  fi

  git tag -a "${tag}" -m "Release ${tag}"
  info "Тег создан: ${tag}"
fi

# ----------------------------
# Push ветки и тегов
# ----------------------------
echo
if [[ "$release_enabled" == "yes" ]]; then
  git push origin "${branch}"
  info "Ветка запушена: origin/${branch}"
  git push origin "${tag}"
  info "Тег релиза запушен: ${tag}"
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
