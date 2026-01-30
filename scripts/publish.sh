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

ask_yes_no() {
  # $1 = вопрос
  local q="$1"
  read -r -p "${q} [y/N]: " ans
  [[ "${ans:-}" =~ ^[Yy]$ ]]
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

# Покажем статус для прозрачности
echo
info "Текущая ветка: $branch"
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
    echo " [3] Откатить изменения"
    echo " [Enter] Отменить publish"
    read -r choice
    if [[ "$choice" == "1" ]]; then
      git add -A
      git commit -m "chore: auto-commit before publish"
      info "Изменения закоммичены автоматически"
      break
    elif [[ "$choice" == "2" ]]; then
      echo "Введите сообщение коммита:"
      read -r message
      if [[ -z "${message:-}" ]]; then
        warn "Сообщение коммита не задано."
      fi
      git add -A
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
      fi
    else
      err "Публикация отменена пользователем."
    fi
  done
fi

# ----------------------------
# Синхронизация с origin
# ----------------------------
if ask_yes_no "Сделать git fetch --tags origin?"; then
  git fetch --tags origin
  info "fetch выполнен"
else
  warn "fetch пропущен"
fi

if ask_yes_no "Сделать git pull --rebase origin/${branch}?"; then
  git pull --rebase origin "$branch"
  info "pull --rebase выполнен"
else
  warn "pull --rebase пропущен"
fi

# ----------------------------
# Версия релиза
# ----------------------------
echo
read -r -p "Введите версию релиза (например 0.1.0): " ver
[[ -n "${ver:-}" ]] || err "Версия не задана."

tag="v${ver}"
deb_ver="${ver}-1"  # Debian revision по умолчанию

echo
info "Релиз: ${tag}"
info "Debian version: ${deb_ver}"
echo

# ----------------------------
# Проверка changelog
# ----------------------------
# В debian/changelog должна быть первая строка вида:
# kbfix (0.1.0-1) unstable; urgency=medium
#
# Скрипт не редактирует автоматически, только проверяет и подсказывает.
if [[ -f "debian/changelog" ]]; then
  head_line="$(head -n 1 debian/changelog || true)"
  if [[ "$head_line" != "kbfix (${deb_ver})"* ]]; then
    warn "debian/changelog не начинается с ожидаемой версии: kbfix (${deb_ver})"
    warn "Сейчас: $head_line"
    err "Обнови debian/changelog под ${deb_ver}, затем запусти publish.sh снова."
  fi
  info "debian/changelog соответствует версии ${deb_ver}"
else
  err "Не найден debian/changelog"
fi

# ----------------------------
# Сборка .deb
# ----------------------------
echo
if ask_yes_no "Собрать .deb пакет через dpkg-buildpackage -us -uc?"; then
  # Чистим старые артефакты именно сборки (не репозиторий!)
  # Важно: debian/ тут трогать нельзя, только ../*.deb и ../*.buildinfo и т.п.
  info "Запускаю сборку..."
  dpkg-buildpackage -us -uc
  info "Сборка завершена"
else
  warn "Сборка пропущена"
fi

# Ищем собранный .deb рядом (dpkg-buildpackage кладет в родительскую директорию)
deb_file=""
deb_expected="../kbfix_${deb_ver}_all.deb"
if [[ -f "$deb_expected" ]]; then
  deb_file="$deb_expected"
  info "Найден .deb: ${deb_file}"
else
  warn ".deb не найден: ${deb_expected}"
  warn "Если сборку пропустили — это нормально. Если собирали — проверь вывод dpkg-buildpackage."
fi

# ----------------------------
# Создание git-тега
# ----------------------------
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

# ----------------------------
# Push ветки и тегов
# ----------------------------
echo
if ask_yes_no "Запушить ветку ${branch} в origin?"; then
  git push origin "${branch}"
  info "Ветка запушена: origin/${branch}"
else
  warn "Push ветки пропущен"
fi

if ask_yes_no "Запушить теги в origin?"; then
  git push origin --tags
  info "Теги запушены"
else
  warn "Push тегов пропущен"
fi

# ----------------------------
# Создание GitHub Release (опционально)
# ----------------------------
echo
if command -v gh >/dev/null 2>&1; then
  info "Найден gh (GitHub CLI). Можно создать Release автоматически."
  if ask_yes_no "Создать GitHub Release ${tag} и прикрепить .deb (если найден)?"; then
    # Формируем базовые notes (кратко, без фантазий)
    notes="KBFix ${tag}\n\n- Debian package build\n- See CHANGELOG.md for details"

    if [[ -n "${deb_file:-}" && -f "${deb_file}" ]]; then
      gh release create "${tag}" "${deb_file}" --title "KBFix ${tag}" --notes "${notes}"
      info "Release создан и .deb прикреплен"
    else
      gh release create "${tag}" --title "KBFix ${tag}" --notes "${notes}"
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

echo
info "Готово. Публикация завершена."
