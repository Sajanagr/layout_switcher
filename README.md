# KBFix

![Build](https://github.com/Sajanagr/layout_switcher/actions/workflows/deb.yml/badge.svg)


Linux-утилита для конвертации **выделенного текста** между RU ↔ EN по горячей клавише  
(аналог Punto Switcher / GxNeur, без изменения системной раскладки).

Проект основан на:
https://github.com/Pilat66/layout_switcher

Но KBFix — это не просто форк, а переработанная desktop-версия с:

— tray-интерфейсом  
— deb-пакетом для установки через систему  
— управлением паузой из панели  
— автозапуском  
— автоопределением направления конвертации  
— исправлением двойных CAPS  
— архитектурой Python-пакета  
— отдельным launcher (`/usr/bin/kbfix`)  

KBFix работает только с выделенным текстом через буфер обмена и **намеренно не управляет системной раскладкой**  
(это сделано осознанно из-за ограничений GNOME / Wayland).

---

## Что планируется дальше

— окно настроек (горячая клавиша, автозапуск, поведение)  
— опциональное переключение системной раскладки через GNOME Shell API  
— уведомления о конвертации  
— подключение словарей `.dic`  
— AppImage / Flatpak сборки  
— автоматическая сборка `.deb` через GitHub Actions  
— улучшение обработки Wayland  
— логирование и просмотр / сохранение логов из tray  

---

## Возможности

— Конвертация выделенного текста RU ↔ EN  
— Горячая клавиша: **Ctrl_L + Super_L + (X | C | С | Ч)**  
— Автоопределение направления конвертации  
— Исправление двойных CAPS (ПРивет → Привет)  
— Tray-приложение (иконка в системной панели)  
— Пауза / возобновление работы из трея  
— Автозапуск  

---

## Требования

Ubuntu / Debian с GNOME (или совместимая среда с AppIndicator)

Зависимости (устанавливаются автоматически через apt):

— python3  
— python3-gi  
— gir1.2-ayatanaappindicator3-0.1  
— python3-pynput  
— python3-pyperclip  

---

## Установка (рекомендуется)

Скачайте .deb пакет из релизов GitHub и установите:

```bash
sudo dpkg -i kbfix_0.1.0-1_all.deb
```

После установки:

— приложение появляется в меню  
— доступна команда `kbfix`  
— появляется иконка в tray  

---

## Запуск

Из меню приложений:

KBFix

или из терминала:

```bash
kbfix
```

---

## Использование

1. Выделите текст в любом приложении
2. Нажмите:

```
Ctrl_L + Super_L + X
```

(или C / С / Ч — срабатывает любой символ кластера)

Выделенный текст будет заменён на сконвертированный.

---

## Установка (рекомендуется, через .deb)

Скачайте последний релиз с GitHub и установите пакет:

```bash
wget https://github.com/Sajanagr/layout_switcher/releases/latest/download/kbfix_0.1.0-1_all.deb
sudo dpkg -i kbfix_0.1.0-1_all.deb
```

Если dpkg сообщит о недостающих зависимостях — выполните:

```bash
sudo apt -f install
```

После установки:

— приложение появляется в меню
— доступна команда `kbfix`
— появляется иконка в tray

## Удаление

```bash
sudo apt remove kbfix
```

## Установка из исходников (для разработки)

```bash
git clone https://github.com/Sajanagr/layout_switcher.git
cd layout_switcher
chmod +x install.sh
./install.sh
```

---

## Архитектура (кратко)

— Python package: `kbfix`
— Tray UI: GTK + AyatanaAppIndicator
— Hotkey listener: pynput
— Clipboard: pyperclip
— Debian launcher: `/usr/bin/kbfix`

---

## Принципы проекта

— работа ТОЛЬКО через выделенный текст
— никакого IBus / GNOME layout API
— минимум побочных эффектов
— GUI desktop application

---

## Примечания

— KBFix намеренно не меняет системную раскладку (ограничения GNOME / Wayland)  
— Конвертация работает только с выделенным текстом  
— Приложение должно быть запущено (tray icon активен)  
— Wayland поддерживается через pynput + clipboard, без low-level hooks  

---

Автор форка: Sajanagr
Основано на работе Pilat66
[https://github.com/Pilat66/layout_switcher](https://github.com/Pilat66/layout_switcher)
