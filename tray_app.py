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
import logging
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
from layout_switcher import HotkeyListener, logger


def parse_args():
    """Разбор аргументов только для уровня логирования"""
    parser = argparse.ArgumentParser(description="Layout switcher tray UI")
    parser.add_argument("--debug", action="store_true", help="Включить отладочные логи")
    return parser.parse_args()


class TrayApp:
    """GUI-обертка над HotkeyListener для управления из трея"""

    def __init__(self, listener: HotkeyListener):
        # Сохраняем слушатель, чтобы управлять паузой и остановкой
        self._listener = listener
        # Иконка рабочего режима берётся из системной темы
        self._icon_running = "kbfix"
        # Иконка паузы берётся из системной темы
        self._icon_paused = "media-playback-pause"

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

        # Пункт "Посмотреть лог" — заглушка для будущей интеграции
        log_item = Gtk.MenuItem(label="Посмотреть лог")
        log_item.connect("activate", self._on_show_log)
        menu.append(log_item)

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
        if new_state:
            self._listener._paused.set()
        else:
            self._listener._paused.clear()
        self._update_indicator_state()

    def _on_show_log(self, _):
        """Заглушка: просмотр лога будет реализован позже"""
        pass

    def _on_settings(self, _):
        """Заглушка: окно настроек будет реализовано позже"""
        pass

    def _on_quit(self, _):
        """Останавливает слушатель и завершает GTK main loop"""
        logger.info("Завершение работы по команде из трея")
        self._listener.stop()
        Gtk.main_quit()


def main():
    # Запускаем управляемый слушатель хоткея
    listener = HotkeyListener()
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
