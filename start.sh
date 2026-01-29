#!/bin/bash

# Скрипт для запуска layout_switcher через systemd
# Должен быть исполняемым: chmod +x start.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || exit 1

# Активация виртуального окружения
if [ -f "venv/bin/activate" ]; then
    source venv/bin/activate
else
    echo "Error: Virtual environment not found at $SCRIPT_DIR/venv/bin/activate" >&2
    exit 1
fi

# Запуск Python скрипта
exec python3 layout_switcher.py "$@"
