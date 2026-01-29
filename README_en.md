# layout_switcher  
Keyboard Layout Switcher Script (Simple Alternative to Punto Switcher, gxNeur)  

This script switches the keyboard layout of selected text when pressing the **Scroll-Lock** key (or **win**). It supports only **Russian-Latin** layout conversion.  

### Key Features:  
- Works with **selected text only**  
- **Converts text AND switches keyboard layout**  
- Does **not** modify last typed text without selection (this functionality is complex and problematic even in Punto Switcher and gxNeur)  

The script runs in the background and intercepts **Pause/Break** key presses to perform layout switching on selected text.  

Theoretically works in both GNOME and KDE, but has only been tested in KDE.  

---

## Installation  

### Requirements:  
The script requires permissions for keyboard control and clipboard access. On Linux, you may need to install additional packages (`xclip` or `xsel`).  

### Python Packages:  
Install required Python packages:  

```bash  
python3 -m venv venv  
source venv/bin/activate  
pip install pyperclip pynput  
python3 layout_switcher.py  
```  

### Optional: Launch Script  
You can create a bash script for easier execution:  

```bash  
#!/bin/bash  

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"  
cd "$SCRIPT_DIR"  
source venv/bin/activate  
python3 layout_switcher.py  
```  

---

## Usage  

1. **Save the script** as `layout_switcher.py`  
2. **Make it executable**:  
   ```bash  
   chmod +x layout_switcher.py  
   ```  
3. **Run the script**:  
   ```bash  
   ./layout_switcher.py  
   ```  

Now when you **select text** and press **Pause/Break**, the selected text will be replaced with the switched layout version.  

---

## Autostart (Untested)  

To launch the script automatically on system startup in **KUbuntu**:  

1. Open **System Settings** → **Startup and Shutdown** → **Autostart**  
2. Add a new task and specify the path to your script  

---

## Library Documentation  

### pyperclip:  
- `pyperclip.copy(text)` - copies text to clipboard  
- `pyperclip.paste()` - returns clipboard contents  
- Cross-platform clipboard operations  

### pynput.keyboard:  
- `keyboard.Controller()` - creates keyboard emulation object  
- `keyboard.Listener()` - creates key press listener  
- `controller.press(key)` - emulates key press  
- `controller.release(key)` - emulates key release  
- `controller.tap(key)` - emulates quick key press-release  

### time:  
- `time.sleep(seconds)` - pauses execution for specified time  

---

## How It Works  

1. Saves current clipboard contents  
2. Copies selected text (Ctrl+C)  
3. Converts text between layouts  
4. Pastes converted text (Ctrl+V)  
5. Restores original clipboard contents  

All operations complete in fractions of a second.  


# PS

Written by deepseek.com
https://github.com/Pilat66/layout_switcher

