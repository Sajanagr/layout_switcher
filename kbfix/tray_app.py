#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Tray UI для управления layout_switcher.
Системную раскладку НЕ меняем, только конвертируем выделенный текст.
"""

# --- Зависимости ОС для Ubuntu ---
# sudo apt install python3-gi gir1.2-ayatanaappindicator3-0.1
# (в некоторых системах вместо ayatana нужно: gir1.2-appindicator3-0.1)

import argparse
import atexit
import fcntl
import logging
from logging.handlers import RotatingFileHandler
import os
import shutil
import subprocess
import signal
import sys
import gi

# Пробуем AyatanaAppIndicator3 (актуальный для Ubuntu), иначе AppIndicator3
try:
    gi.require_version('AyatanaAppIndicator3', '0.1')
    from gi.repository import AyatanaAppIndicator3 as AppIndicator3
except (ValueError, ImportError):
    gi.require_version('AppIndicator3', '0.1')
    from gi.repository import AppIndicator3

gi.require_version('Gtk', '3.0')
from gi.repository import Gtk

# Используем общий логгер из layout_switcher, чтобы не плодить разные каналы
from kbfix.layout_switcher import HotkeyListener, logger


_lock_fd: int | None = None
_listener_ref: HotkeyListener | None = None
_is_shutting_down: bool = False


def acquire_single_instance_lock() -> None:
    """Захватывает lock-файл, чтобы приложение работало в одном экземпляре"""
    global _lock_fd
    lock_path = os.path.expanduser("~/.local/state/kbfix/kbfix.lock")
    os.makedirs(os.path.dirname(lock_path), exist_ok=True)
    _lock_fd = os.open(lock_path, os.O_CREAT | os.O_RDWR, 0o644)
    try:
        fcntl.flock(_lock_fd, fcntl.LOCK_EX | fcntl.LOCK_NB)
        os.ftruncate(_lock_fd, 0)
        os.write(_lock_fd, f"{os.getpid()}\n".encode("utf-8"))
        os.fsync(_lock_fd)
        logger.info("Single-instance: lock acquired (PID: %s)", os.getpid())
    except Exception:
        pid_text: str | None = None
        try:
            os.lseek(_lock_fd, 0, os.SEEK_SET)
            data = os.read(_lock_fd, 64).decode("utf-8").strip()
            if data:
                pid_text = data.splitlines()[0]
        except Exception:
            pid_text = None
        if pid_text:
            logger.info("Single-instance: already running (PID: %s)", pid_text)
            message = f"KBFix уже запущен (PID: {pid_text})"
        else:
            logger.info("Single-instance: already running")
            message = "KBFix уже запущен"
        print(message, file=sys.stderr)
        try:
            os.close(_lock_fd)
        except Exception:
            pass
        _lock_fd = None
        sys.exit(0)


def release_single_instance_lock() -> None:
    """Освобождает lock-файл"""
    global _lock_fd
    if _lock_fd is None:
        return
    try:
        try:
            fcntl.flock(_lock_fd, fcntl.LOCK_UN)
        except Exception:
            logger.exception("Не удалось снять блокировку с lock-файла")
        os.close(_lock_fd)
    except Exception:
        logger.exception("Не удалось закрыть lock-файл")
    _lock_fd = None


def parse_args():
    """Разбор аргументов только для уровня логирования"""
    parser = argparse.ArgumentParser(description="Layout switcher tray UI")
    parser.add_argument("--debug", action="store_true", help="Включить отладочные логи")
    return parser.parse_args()


def _handle_signal(signum, _frame) -> None:
    """Завершает приложение при получении сигнала"""
    try:
        signal_name = signal.Signals(signum).name
    except Exception:
        signal_name = str(signum)
    safe_shutdown(f"signal {signal_name}")
    sys.exit(0)


def safe_shutdown(reason: str) -> None:
    """Корректно завершает приложение"""
    global _is_shutting_down
    if _is_shutting_down:
        return
    _is_shutting_down = True
    logger.info("Shutdown: %s", reason)
    if _listener_ref is not None:
        try:
            _listener_ref.stop()
        except Exception:
            logger.exception("Не удалось остановить HotkeyListener")
    try:
        release_single_instance_lock()
    except Exception:
        logger.exception("Не удалось освободить single-instance lock")
    try:
        Gtk.main_quit()
    except Exception:
        pass


def _atexit_shutdown() -> None:
    """Завершение приложения через atexit"""
    safe_shutdown("atexit")


class TrayApp:
    """GUI-обертка над HotkeyListener для управления из трея"""

    def __init__(self, listener: HotkeyListener):
        # Сохраняем слушатель, чтобы управлять паузой и остановкой
        self._listener = listener
        # Иконка рабочего режима берётся из системной темы
        self._icon_running = "kbfix"
        # Иконка паузы берётся из системной темы
        self._icon_paused = "media-playback-pause"
        # Состояние файлового логирования
        self._file_logging_enabled = False
        self._file_handler: logging.FileHandler | None = None
        self._prev_logger_level: int | None = None
        self._file_log_path = os.path.abspath(
            os.path.expanduser("~/.local/state/kbfix/kbfix.log")
        )

        # Создаём индикатор в трее с системной иконкой клавиатуры
        self._indicator = AppIndicator3.Indicator.new(
            "layout_switcher",
            "input-keyboard",
            AppIndicator3.IndicatorCategory.APPLICATION_STATUS
        )
        self._indicator.set_status(AppIndicator3.IndicatorStatus.ACTIVE)

        # Формируем меню трея
        menu = Gtk.Menu()

        # Пункт Пауза/Возобновить (переключатель), меняет состояние paused
        self._toggle_item = Gtk.MenuItem(label="Пауза")
        self._toggle_item.connect("activate", self._on_toggle_pause)
        menu.append(self._toggle_item)

        # Разделитель для аккуратного вида
        menu.append(Gtk.SeparatorMenuItem())

        # Пункт включения/выключения файлового лога
        self._file_log_item = Gtk.MenuItem(label="Включить файловый лог")
        self._file_log_item.connect("activate", self._on_toggle_file_log)
        menu.append(self._file_log_item)

        # Пункт "Посмотреть лог"
        log_item = Gtk.MenuItem(label="Посмотреть лог")
        log_item.connect("activate", self._on_show_log)
        menu.append(log_item)
        menu.append(Gtk.SeparatorMenuItem())

        # Пункт "Настройка" — заглушка для будущего окна настроек
        settings_item = Gtk.MenuItem(label="Настройка")
        settings_item.connect("activate", self._on_settings)
        menu.append(settings_item)

        # Разделитель для аккуратного вида
        menu.append(Gtk.SeparatorMenuItem())

        # Пункт Выход — корректно останавливает слушатель и завершает приложение
        quit_item = Gtk.MenuItem(label="Выход")
        quit_item.connect("activate", self._on_quit)
        menu.append(quit_item)

        menu.show_all()
        self._indicator.set_menu(menu)

        # Устанавливаем состояние UI в соответствии с текущей паузой
        self._update_indicator_state()
        # Устанавливаем текст пункта файлового лога
        self._update_file_log_menu_state()

    def _update_indicator_state(self):
        """Обновляет иконку и tooltip в зависимости от состояния paused"""
        if self._listener.is_paused():
            # В режиме паузы показываем системную иконку паузы без текстового label
            # и задаём tooltip, чтобы пользователь понимал состояние
            self._indicator.set_icon_full(self._icon_paused, "KBFix — пауза")
            self._indicator.set_title("KBFix — пауза")
            self._toggle_item.set_label("Возобновить")
        else:
            # В рабочем режиме показываем пользовательскую иконку без текстового label
            # и задаём tooltip с понятным статусом
            self._indicator.set_icon_full(self._icon_running, "KBFix — работает")
            self._indicator.set_title("KBFix — работает")
            self._toggle_item.set_label("Пауза")

    def _on_toggle_pause(self, _):
        """Переключает паузу и обновляет отображение"""
        new_state = not self._listener.is_paused()
        # Меняем флаг паузы напрямую, чтобы не спамить логами при каждом клике
        self._listener.set_paused(new_state)
        self._update_indicator_state()

    def _on_toggle_file_log(self, _):
        """Переключает файловое логирование"""
        if self._file_logging_enabled:
            # Важно: сначала пишем в лог, потом отключаем handler
            logger.info("Файловый лог выключен")
            if self._file_handler is not None:
                try:
                    self._file_handler.flush()
                except Exception:
                    logger.exception("Не удалось flush() файлового лога перед выключением")
            if self._file_handler is not None:
                root_logger = logging.getLogger()
                root_logger.removeHandler(self._file_handler)
                self._file_handler.close()
            self._file_handler = None
            if self._prev_logger_level is not None:
                logger.setLevel(self._prev_logger_level)
                self._prev_logger_level = None
            self._file_logging_enabled = False
        else:
            log_dir = os.path.dirname(self._file_log_path)
            os.makedirs(log_dir, exist_ok=True)
            self._file_handler = RotatingFileHandler(
                self._file_log_path,
                maxBytes=1 * 1024 * 1024,
                backupCount=2,
                encoding="utf-8"
            )
            self._file_handler.setLevel(logging.DEBUG)
            self._file_handler.setFormatter(
                logging.Formatter("%(asctime)s %(levelname)s %(message)s")
            )
            root_logger = logging.getLogger()
            root_logger.addHandler(self._file_handler)
            self._prev_logger_level = logger.getEffectiveLevel()
            logger.setLevel(logging.DEBUG)
            self._file_logging_enabled = True
            logger.info("Файловый лог включён (DEBUG): %s", self._file_log_path)
        self._update_file_log_menu_state()

    def _update_file_log_menu_state(self):
        """Обновляет подпись пункта меню для файлового лога"""
        if self._file_logging_enabled:
            self._file_log_item.set_label("Выключить файловый лог")
        else:
            self._file_log_item.set_label("Включить файловый лог")

    def _on_show_log(self, _):
        """Открывает файл лога в приложении по умолчанию"""
        if not os.path.exists(self._file_log_path):
            message = (
                "Файл лога не найден.\n"
                "Включите файловый лог и повторите.\n"
                f"Путь: {self._file_log_path}"
            )
            if shutil.which("zenity"):
                try:
                    subprocess.Popen(["zenity", "--info", "--no-wrap", f"--text={message}"])
                except Exception:
                    logger.exception("Не удалось показать сообщение через zenity")
            else:
                logger.info(message)
            return

        try:
            if shutil.which("xdg-open"):
                subprocess.Popen(["xdg-open", self._file_log_path])
                return
        except Exception:
            logger.exception("Не удалось открыть лог через xdg-open")

        try:
            if shutil.which("gio"):
                subprocess.Popen(["gio", "open", self._file_log_path])
                return
        except Exception:
            logger.exception("Не удалось открыть лог через gio")

        logger.error("Не удалось открыть файл лога: %s", self._file_log_path)

    def _on_settings(self, _):
        """Заглушка: окно настроек будет реализовано позже"""
        pass

    def _on_quit(self, _):
        """Останавливает слушатель и завершает GTK main loop"""
        safe_shutdown("quit from tray")


def main():
    acquire_single_instance_lock()
    atexit.register(_atexit_shutdown)
    signal.signal(signal.SIGINT, _handle_signal)
    signal.signal(signal.SIGTERM, _handle_signal)
    # Запускаем управляемый слушатель хоткея
    listener = HotkeyListener()
    global _listener_ref
    _listener_ref = listener
    listener.start()

    # Логируем общий статус (системную раскладку намеренно не трогаем)
    logger.info(
        "Скрипт конвертирует только выделенный текст. Горячая клавиша: Ctrl_L + Super_L + (X | C | с | ч)."
    )

    # Поднимаем трей-приложение
    TrayApp(listener)
    Gtk.main()


if __name__ == "__main__":
    args = parse_args()
    log_level = logging.DEBUG if args.debug else logging.INFO
    logging.basicConfig(level=log_level, format="%(asctime)s %(levelname)s %(message)s")
    main()
