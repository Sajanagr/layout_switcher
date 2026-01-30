#!/usr/bin/env bash
# install.sh
# Назначение: установить KBFix как "пользовательское" приложение (без sudo):
# 1) поставить иконку в ~/.local/share/icons (Icon=kbfix)
# 2) установить .desktop в меню приложений и в автозапуск
# 3) установить python-пакет (pip --user -e .), чтобы запуск работал через `python3 -m kbfix`
#
# Канон:
# - НЕ трогаем системную раскладку (тут это и не делается)
# - НЕ используем абсолютные пути для Icon в .desktop (тут будет Icon=kbfix)
#
# Скрипт безопасен: работает только в HOME пользователя.

set -euo pipefail

# ----------------------------
# 0) Определяем пути
# ----------------------------
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ICON_BASE="$HOME/.local/share/icons/hicolor"
ICON_DIR="$ICON_BASE/128x128/apps"

APP_DIR="$HOME/.local/share/applications"
AUTOSTART_DIR="$HOME/.config/autostart"

DESKTOP_SRC="$REPO_DIR/desktop/kbfix.desktop"
ICON_SRC="$REPO_DIR/assets/kbfix.png"

DESKTOP_DST_APP="$APP_DIR/kbfix.desktop"
DESKTOP_DST_AUTOSTART="$AUTOSTART_DIR/kbfix.desktop"
ICON_DST="$ICON_DIR/kbfix.png"

# ----------------------------
# 1) Утилиты для вывода
# ----------------------------
info()  { echo "OK: $*"; }
warn()  { echo "WARN: $*" >&2; }
fail()  { echo "ERROR: $*" >&2; exit 1; }

# ----------------------------
# 2) Проверка зависимостей и файлов
# ----------------------------

# 2.1. Проверяем обязательные команды (то, без чего установка не имеет смысла)
command -v bash >/dev/null 2>&1 || fail "bash не найден"
command -v python3 >/dev/null 2>&1 || fail "python3 не найден (нужен Python 3)"
command -v pip3 >/dev/null 2>&1 || warn "pip3 не найден как отдельная команда — попробуем python3 -m pip"

# 2.2. Проверяем, что python3 умеет pip
if ! python3 -m pip --version >/dev/null 2>&1; then
  fail "Python pip не найден. Установи pip (обычно пакет python3-pip) и повтори."
fi

# 2.3. Проверяем, что исходные файлы на месте
[[ -f "$ICON_SRC" ]]   || fail "Не найден файл иконки: $ICON_SRC"
[[ -f "$DESKTOP_SRC" ]]|| fail "Не найден desktop-файл: $DESKTOP_SRC"

# 2.4. Проверяем python-зависимости проекта (те, что реально нужны в рантайме)
# Важно: мы проверяем импорты, чтобы пользователь сразу увидел проблему,
# если в системе нет нужных python-библиотек (pynput, pyperclip, gi).
python3 - <<'PY' || fail "Не хватает Python-зависимостей. Смотри сообщение выше."
import importlib, sys

required = [
    ("pynput", "pynput"),
    ("pyperclip", "pyperclip"),
    ("gi", "PyGObject (python3-gi)"),
]

missing = []
for mod, hint in required:
    try:
        importlib.import_module(mod)
    except Exception as e:
        missing.append((mod, hint, str(e)))

if missing:
    print("Не найдены/не импортируются Python-модули:", file=sys.stderr)
    for mod, hint, err in missing:
        print(f" - {mod} (подсказка: {hint}); ошибка: {err}", file=sys.stderr)
    sys.exit(1)

# Отдельно проверим, что есть нужные компоненты GTK для индикатора
try:
    import gi
    gi.require_version("Gtk", "3.0")
    gi.require_version("AppIndicator3", "0.1")
except Exception as e:
    print("GTK/AppIndicator зависимости не готовы:", e, file=sys.stderr)
    sys.exit(1)

print("Python-зависимости: OK")
PY

info "Проверка зависимостей пройдена"

# ----------------------------
# 3) Создаём каталоги назначения
# ----------------------------
mkdir -p "$ICON_DIR" "$APP_DIR" "$AUTOSTART_DIR"
info "Каталоги созданы:
 - $ICON_DIR
 - $APP_DIR
 - $AUTOSTART_DIR"

# ----------------------------
# 4) Устанавливаем иконку в icon theme (hicolor)
# ----------------------------
cp -f "$ICON_SRC" "$ICON_DST"
info "Иконка установлена: $ICON_DST"

# ----------------------------
# 5) Устанавливаем .desktop в меню и в автозапуск
# ----------------------------

# Копируем исходный desktop в два места
cp -f "$DESKTOP_SRC" "$DESKTOP_DST_APP"
cp -f "$DESKTOP_SRC" "$DESKTOP_DST_AUTOSTART"

# Приводим Icon к канону: Icon=kbfix (без абсолютных путей)
# (работает, даже если Icon уже правильный)
sed -i 's/^Icon=.*/Icon=kbfix/' "$DESKTOP_DST_APP"
sed -i 's/^Icon=.*/Icon=kbfix/' "$DESKTOP_DST_AUTOSTART"

# Здесь НЕ правим Exec автоматически, потому что он зависит от того,
# как именно ты хочешь запускать (python3 -m kbfix / entrypoint kbfix).
# Exec правим в самом desktop-файле в репозитории (и потом переустанавливаем).
info ".desktop-файлы установлены:
 - $DESKTOP_DST_APP
 - $DESKTOP_DST_AUTOSTART
Icon приведён к виду: Icon=kbfix"

# ----------------------------
# 6) Устанавливаем python-пакет (editable, в HOME пользователя)
# ----------------------------
# Установка пакета в пользовательский каталог.
# На Ubuntu может быть PEP 668: externally-managed-environment.
# В таком случае используем --break-system-packages, чтобы разрешить установку в ~/.local
if python3 -m pip install --user -e "$REPO_DIR" >/dev/null 2>&1; then
  info "Python-пакет установлен: pip --user -e"
else
  warn "pip --user -e не сработал (PEP 668). Повтор с --break-system-packages..."
  python3 -m pip install --user -e "$REPO_DIR" --break-system-packages >/dev/null
  info "Python-пакет установлен: pip --user -e --break-system-packages"
fi

# Проверяем, что модуль kbfix реально находится и запускается.
# Если пакет ещё не оформлен (нет kbfix/__main__.py и т.п.), будет понятная ошибка.
if python3 -m kbfix --help >/dev/null 2>&1; then
  info "Проверка запуска: python3 -m kbfix (OK)"
else
  warn "Проверка запуска не прошла: python3 -m kbfix"
  warn "Скорее всего, пакет kbfix ещё не оформлен (нужны kbfix/ и __main__.py) или зависимости не установлены."
fi


info "Python-пакет установлен: pip --user -e $REPO_DIR"

# ----------------------------
# 7) Обновляем кэш иконок и базу desktop (если утилиты доступны)
# ----------------------------
if command -v gtk-update-icon-cache >/dev/null 2>&1; then
  gtk-update-icon-cache -f -t "$ICON_BASE" >/dev/null 2>&1 || true
  info "Кэш иконок обновлён (gtk-update-icon-cache)"
else
  warn "gtk-update-icon-cache не найден — пропускаю обновление кэша иконок"
fi

if command -v update-desktop-database >/dev/null 2>&1; then
  update-desktop-database "$APP_DIR" >/dev/null 2>&1 || true
  info "База desktop обновлена (update-desktop-database)"
else
  warn "update-desktop-database не найден — пропускаю обновление базы desktop"
fi

# ----------------------------
# 8) Итог и подсказка пользователю
# ----------------------------
echo
info "Установка завершена."

echo "Проверка запуска (ручной тест):"
echo "  python3 -m kbfix"

echo
echo "Если приложение не появилось в меню сразу — перелогинься (выход/вход в GNOME) или перезапусти Shell."

exit 0
