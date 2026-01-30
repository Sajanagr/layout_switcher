# KBFix

Linux-утилита для конвертации **выделенного текста** между RU ↔ EN по горячей клавише  
(аналог Punto Switcher/GxNeur, без изменения системной раскладки).

Проект является форком:
https://github.com/Pilat66/layout_switcher

KBFix работает только с выделенным текстом через буфер обмена и **намеренно не управляет системной раскладкой**.

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

## Удаление

```bash
sudo apt remove kbfix
```

---

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
— никаких Alt / Ctrl+Space
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
