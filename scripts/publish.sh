#!/usr/bin/env bash
# ---------------------------------------------------------------
# Файл: scripts/publish.sh
# Назначение: Публикация релиза KBFix в GitHub (тег + сборка .deb + push + release).
#
# Скрипт рассчитан на открытый open-source поток:
#  - работает через git-теги вида v0.1.0
#  - собирает .deb через dpkg-buildpackage
#  - пушит ветку и теги
#  - опционально создает GitHub Release через gh и прикрепляет .deb
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
if ! ask_yes_no "Публиковать из ветки ${branch}?"; then
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
    echo " [5] Полная очистка включая ignored (git clean -ffdx, ОЧЕНЬ ОПАСНО)"
    echo " [Enter] Отменить publish"
    echo -n "Выбор действия: "
    read -r choice
    if [[ -z "${choice:-}" ]]; then
      err "Публикация отменена пользователем."
    elif [[ "$choice" == "1" ]]; then
      git add -u
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
      git add -u
      if git diff --cached --quiet; then
        warn "Нет staged изменений. Возможны только untracked файлы. Добавь их вручную или выбери другую опцию."
        continue
      fi
      git commit -m "$message"
      info "Изменения закоммичены с пользовательским сообщением"
      break
    elif [[ "$choice" == "3" ]]; then
      echo "Подтвердите откат изменений. Введите YES:"
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
      echo "Очистка удалит untracked файлы. Введите YES:"
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
      echo "Полная очистка удалит untracked и ignored файлы. Введите YES:"
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
if ask_yes_no "Обновить список тегов из origin (git fetch --tags)?"; then
  git fetch --tags origin
  info "Обновление тегов выполнено"
else
  warn "fetch пропущен"
fi

if ask_yes_no "Обновить текущую ветку ${branch} из origin с rebase?"; then
  git pull --rebase origin "$branch"
  info "Обновление ветки выполнено"
else
  warn "pull --rebase пропущен"
fi

# ----------------------------
# Версия релиза
# ----------------------------
release_enabled="no"
if ask_yes_no "Выпускать релиз (тег + GitHub Release)?"; then
  release_enabled="yes"
fi

if [[ "$release_enabled" == "yes" ]]; then
  echo
  read -r -p "Введите версию релиза (например 0.1.0): " ver
  [[ -n "${ver:-}" ]] || err "Версия не задана."
  ver="${ver#v}"
  tag="v${ver}"
  deb_ver="${ver}-1"  # Debian revision по умолчанию
else
  ver=""
  tag=""
  deb_ver=""
fi

echo
if [[ "$release_enabled" == "yes" ]]; then
  info "Релиз: ${tag}"
  info "Debian version: ${deb_ver}"
else
  warn "Режим без релиза: теги и GitHub Release пропущены."
fi
echo

# ----------------------------
# Проверка changelog
# ----------------------------
# В debian/changelog должна быть первая строка вида:
# kbfix (0.1.0-1) unstable; urgency=medium
#
# Скрипт не редактирует автоматически, только проверяет и подсказывает.
if [[ "$release_enabled" == "yes" ]]; then
  if [[ -f "debian/changelog" ]]; then
    head_line="$(head -n 1 debian/changelog || true)"
    if [[ "$head_line" != "${pkg_name} (${deb_ver})"* ]]; then
      warn "debian/changelog не начинается с ожидаемой версии: ${pkg_name} (${deb_ver})"
      warn "Сейчас: $head_line"
      err "Обнови debian/changelog под ${deb_ver}, затем запусти publish.sh снова."
    fi
    info "debian/changelog соответствует версии ${deb_ver}"
  else
    err "Не найден debian/changelog"
  fi
fi

# ----------------------------
# Сборка .deb
# ----------------------------
build_done="no"
echo
if ask_yes_no "Собрать .deb пакет через dpkg-buildpackage -us -uc?"; then
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
  # Проверяем, что тег не существует
  if git rev-parse -q --verify "refs/tags/${tag}" >/dev/null; then
    warn "Тег ${tag} уже существует. Создание тега будет пропущено."
    tag_already_exists="yes"
  else
    tag_already_exists="no"
  fi

  if [[ "$tag_already_exists" == "no" ]]; then
    if ask_yes_no "Создать annotated tag ${tag} на текущем коммите?"; then
      git tag -a "${tag}" -m "Release ${tag}"
      info "Тег создан: ${tag}"
    else
      warn "Тег не создан"
    fi
  fi
fi

# ----------------------------
# Push ветки и тегов
# ----------------------------
echo
if ask_yes_no "Отправить ветку ${branch} в origin (git push)?"; then
  git push origin "${branch}"
  info "Ветка запушена: origin/${branch}"
else
  warn "Push ветки пропущен"
fi

if [[ "$release_enabled" == "yes" ]]; then
  if ask_yes_no "Запушить теги в origin?"; then
    git push origin --tags
    info "Теги запушены"
  else
    warn "Push тегов пропущен"
  fi
fi

# ----------------------------
# Создание GitHub Release (опционально)
# ----------------------------
if [[ "$release_enabled" == "yes" ]]; then
  echo
  if command -v gh >/dev/null 2>&1; then
    info "Найден gh (GitHub CLI). Можно создать Release автоматически."
    if ask_yes_no "Создать GitHub Release ${tag} и прикрепить .deb (если найден)?"; then
      # Формируем базовые notes (кратко, без фантазий)
      notes="$(printf '%s\n\n- Debian package build\n- See debian/changelog for details' "${pkg_name} ${tag}")"

      if [[ -n "${deb_file:-}" && -f "${deb_file}" ]]; then
        gh release create "${tag}" "${deb_file}" --title "${pkg_name} ${tag}" --notes "${notes}"
        info "Release создан и .deb прикреплен"
      else
        gh release create "${tag}" --title "${pkg_name} ${tag}" --notes "${notes}"
        warn "Release создан без .deb (файл не найден)"
      fi
    else
      warn "Создание Release пропущено"
    fi
  else
    warn "gh не найден. Release можно сделать вручную через веб-интерфейс GitHub."
    if [[ -n "${deb_file:-}" ]]; then
      warn "Файл для загрузки: ${deb_file}"
    fi
  fi
fi

echo
info "Готово. Публикация завершена."
