# KBFix

Linux utility for converting **selected text** between RU ↔ EN using a hotkey  
(Punto Switcher / GxNeur alternative, without changing system keyboard layout).

This project is a fork of:
https://github.com/Pilat66/layout_switcher

KBFix works only with selected text via clipboard and **intentionally does not control system layout**.

---

## Features

— Selected text conversion RU ↔ EN  
— Hotkey: **Ctrl_L + Super_L + (X | C | С | Ч)**  
— Automatic direction detection  
— Double CAPS fix (HEllo → Hello)  
— Tray application (system panel icon)  
— Pause / resume from tray  
— Autostart  

---

## Requirements

Ubuntu / Debian with GNOME (or compatible environment with AppIndicator)

Dependencies (installed automatically via apt):

— python3  
— python3-gi  
— gir1.2-ayatanaappindicator3-0.1  
— python3-pynput  
— python3-pyperclip  

---

## Installation (recommended)

Download the .deb package from GitHub releases and install:

```bash
sudo dpkg -i kbfix_0.1.0-1_all.deb
```

After installation:

— application appears in menu  
— `kbfix` command becomes available  
— tray icon appears  

---

## Launch

From application menu:

KBFix

or from terminal:

```bash
kbfix
```

---

## Usage

1. Select text in any application
2. Press:

```
Ctrl_L + Super_L + X
```

(or C / С / Ч — any key from the cluster works)

Selected text will be replaced with converted one.

---

## Removal

```bash
sudo apt remove kbfix
```

---

## Install from sources (development)

```bash
git clone https://github.com/Sajanagr/layout_switcher.git
cd layout_switcher
chmod +x install.sh
./install.sh
```

---

## Architecture (short)

— Python package: `kbfix`
— Tray UI: GTK + AyatanaAppIndicator
— Hotkey listener: pynput
— Clipboard: pyperclip
— Debian launcher: `/usr/bin/kbfix`

---

## Project principles

— selected text only
— no IBus / GNOME layout API
— no Alt / Ctrl+Space
— minimal side effects
— GUI desktop application

---

## Notes

— KBFix intentionally does not change system keyboard layout (GNOME / Wayland limitations)  
— Conversion works with selected text only  
— Application must be running (tray icon active)  
— Wayland is supported via pynput + clipboard (no low-level hooks)  

---

Fork author: Sajanagr
Based on Pilat66 work
[https://github.com/Pilat66/layout_switcher](https://github.com/Pilat66/layout_switcher)
