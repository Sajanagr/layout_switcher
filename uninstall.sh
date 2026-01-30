#!/usr/bin/env bash
# uninstall.sh
#
# Полное удаление KBFix из профиля пользователя.
# Скрипт НЕ требует sudo и работает только в HOME.
#
# Удаляет:
# - python-пакет kbfix
# - desktop-файлы
# - автозапуск
# - иконку
# - обновляет кэши GTK

set -euo pipefail

APP_DESKTOP="$HOME/.local/share/applications/kbfix.desktop"
AUTOSTART_DESKTOP="$HOME/.config/autostart/kbfix.desktop"
ICON_FILE="$HOME/.local/share/icons/hicolor/128x128/apps/kbfix.png"
ICON_BASE="$HOME/.local/share/icons/hicolor"
APP_DIR="$HOME/.local/share/applications"

info()  { echo "OK: $*"; }
warn()  { echo "WARN: $*" >&2; }

# ----------------------------
# Удаление python-пакета
# ----------------------------

if python3 -m pip uninstall -y kbfix >/dev/null 2>&1; then
  info "Python-пакет kbfix удалён"
else
  warn "Обычный uninstall не сработал. Пробую с --break-system-packages..."
  python3 -m pip uninstall -y kbfix --break-system-packages >/dev/null || true
  info "Python-пакет kbfix удалён (fallback)"
fi

# ----------------------------
# Удаление desktop файлов
# ----------------------------

rm -f "$APP_DESKTOP"
rm -f "$AUTOSTART_DESKTOP"
info "Desktop-файлы удалены"

# ----------------------------
# Удаление иконки
# ----------------------------

rm -f "$ICON_FILE"
info "Иконка удалена"

# ----------------------------
# Обновление кэшей
# ----------------------------

if command -v gtk-update-icon-cache >/dev/null 2>&1; then
  gtk-update-icon-cache -f -t "$ICON_BASE" >/dev/null 2>&1 || true
  info "Кэш иконок обновлён"
fi

if command -v update-desktop-database >/dev/null 2>&1; then
  update-desktop-database "$APP_DIR" >/dev/null 2>&1 || true
  info "База desktop обновлена"
fi

echo
info "KBFix полностью удалён."
