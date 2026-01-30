# Changelog

Все заметные изменения в проекте KBFix будут фиксироваться здесь.

Формат приближен к Keep a Changelog:
- Added / Changed / Fixed / Removed

---

## [0.1.0] - 2026-01-30

### Added
- Tray-приложение (GTK + AyatanaAppIndicator) для управления работой утилиты.
- Горячая клавиша: Ctrl_L + Super_L + (X | C | С | Ч).
- Автоопределение направления конвертации RU ↔ EN.
- Исправление «двойных CAPS» в словах после конвертации.
- Установка в систему через `.deb` пакет (debian/ + postinst/postrm).
- CLI-лаунчер `kbfix` (через `/usr/bin/kbfix`).

### Changed
- [x] Проект переведён в Python package `kbfix`.
- [x] Экспериментальные материалы вынесены в `experiments/`.

### Removed
- [x] Удалены устаревшие скрипты/артефакты старой структуры проекта (systemd units, старые файлы запуска).

---
