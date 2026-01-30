#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Скрипт для переключения раскладки выделенного текста по нажатию Ctrl_L + Super_L + (x|c|с|ч).
Логика похожа на Punto Switcher, но работает только с выделенным текстом.
"""

# --- Импорты ---
# pyperclip нужен для доступа к буферу обмена (копирование/восстановление текста)
import pyperclip
# pynput нужен для перехвата/эмуляции клавиатуры на уровне системы
from pynput import keyboard
# time нужен для задержек и debounce, чтобы не ловить повторные срабатывания
import time
# argparse нужен только для debug-режима логов
import argparse
import logging
# re нужен для пост-обработки слов с двойными заглавными
import re
# threading нужен для потокобезопасного управления паузой и жизненным циклом слушателя
import threading

# Логгер нужен для управляемого вывода в консоль и диагностики проблем
logger = logging.getLogger("layout_switcher")

# =============================================
# СЛОВАРИ ДЛЯ КОНВЕРТАЦИИ РАСКЛАДОК
# =============================================

# Порог уверенности для авто-конвертации:
# MIN_HITS защищает от случайных совпадений, RATIO требует явного перевеса.
MIN_HITS = 3
RATIO = 2.0

# Триггерные клавиши для кластера хоткея (срабатывает на любой из них).
# Важно: набор включает латиницу и кириллицу, чтобы срабатывание было одинаковым в любой раскладке.
TRIGGER_KEYS = {'x', 'c', 'с', 'ч'}

# Таблица EN -> RU: фиксированная посимвольная замена, как при «перепутанной» раскладке
# Здесь важна симметрия с ru_to_en, чтобы обратное преобразование было корректным
en_to_ru = {
    'q': 'й', 'w': 'ц', 'e': 'у', 'r': 'к', 't': 'е', 'y': 'н', 'u': 'г',
    'i': 'ш', 'o': 'щ', 'p': 'з', '[': 'х', ']': 'ъ', 'a': 'ф', 's': 'ы',
    'd': 'в', 'f': 'а', 'g': 'п', 'h': 'р', 'j': 'о', 'k': 'л', 'l': 'д',
    ';': 'ж', "'": 'э', 'z': 'я', 'x': 'ч', 'c': 'с', 'v': 'м', 'b': 'и',
    'n': 'т', 'm': 'ь', ',': 'б', '.': 'ю', '/': '.', '`': 'ё', '&': '?',
    '@': '"', '#': '№', '$': ';', '^': ':', 'Q': 'Й', 'W': 'Ц', 'E': 'У',
    'R': 'К', 'T': 'Е', 'Y': 'Н', 'U': 'Г', 'I': 'Ш', 'O': 'Щ', 'P': 'З',
    '{': 'Х', '}': 'Ъ', 'A': 'Ф', 'S': 'Ы', 'D': 'В', 'F': 'А', 'G': 'П',
    'H': 'Р', 'J': 'О', 'K': 'Л', 'L': 'Д', ':': 'Ж', '"': 'Э', 'Z': 'Я',
    'X': 'Ч', 'C': 'С', 'V': 'М', 'B': 'И', 'N': 'Т', 'M': 'Ь', '<': 'Б',
    '>': 'Ю', '?': ',', '~': 'Ё'
}

# Таблица RU -> EN: зеркальное преобразование для обратной конвертации
ru_to_en = {
    'й': 'q', 'ц': 'w', 'у': 'e', 'к': 'r', 'е': 't', 'н': 'y', 'г': 'u',
    'ш': 'i', 'щ': 'o', 'з': 'p', 'х': '[', 'ъ': ']', 'ф': 'a', 'ы': 's',
    'в': 'd', 'а': 'f', 'п': 'g', 'р': 'h', 'о': 'j', 'л': 'k', 'д': 'l',
    'ж': ';', 'э': "'", 'я': 'z', 'ч': 'x', 'с': 'c', 'м': 'v', 'и': 'b',
    'т': 'n', 'ь': 'm', 'б': ',', 'ю': '.', 'ё': '`', '?': '&', '"': '@',
    '№': '#', ';': '$', ':': '^', 'Й': 'Q', 'Ц': 'W', 'У': 'E', 'К': 'R',
    'Е': 'T', 'Н': 'Y', 'Г': 'U', 'Ш': 'I', 'Щ': 'O', 'З': 'P', 'Х': '{',
    'Ъ': '}', 'Ф': 'A', 'Ы': 'S', 'В': 'D', 'А': 'F', 'П': 'G', 'Р': 'H',
    'О': 'J', 'Л': 'K', 'Д': 'L', 'Ж': ':', 'Э': '"', 'Я': 'Z', 'Ч': 'X',
    'С': 'C', 'М': 'V', 'И': 'B', 'Т': 'N', 'Ь': 'M', 'Б': '<', 'Ю': '>',
    'Ё': '~', ',': '?', '.': '/'
}

# =============================================
# ФУНКЦИИ ДЛЯ РАБОТЫ С РАСКЛАДКОЙ
# =============================================

# Посимвольная конвертация: она проста и предсказуема,
# и ровно соответствует "ввёл в другой раскладке"

def switch_layout(text):
    """
    Конвертирует текст между русской и английской раскладками.
    Возвращает преобразованный текст.
    """

    result = []
    for char in text:
        if char in en_to_ru:
            result.append(en_to_ru[char])
        elif char in ru_to_en:
            result.append(ru_to_en[char])
        else:
            # Неподдерживаемые символы сохраняем без изменений
            result.append(char)
    return ''.join(result)

# Исправляем слова с двумя и более заглавными в начале, если далее есть строчные
def fix_double_caps(text: str) -> tuple[str, int]:
    pattern = re.compile(r"\b([A-ZА-ЯЁ]{2,})([a-zа-яё]+)([A-Za-zА-Яа-яЁё]*)\b")

    def _fix(match: re.Match) -> str:
        prefix = match.group(1)
        fixed_prefix = prefix[0] + prefix[1:].lower()
        return fixed_prefix + match.group(2) + match.group(3)

    fixed_text, count = pattern.subn(_fix, text)
    return fixed_text, count

# Определяем направление конвертации по количеству совпадений с таблицами,
# чтобы выполнять замену только при высокой вероятности ошибочной раскладки.

def detect_conversion_direction(text):
    """Определяет направление конвертации и возвращает (direction, en_hits, ru_hits)"""
    en_hits = 0
    ru_hits = 0
    for char in text:
        # Учитываем символ только в одной корзине, чтобы избежать двойного счёта.
        if char in en_to_ru:
            en_hits += 1
        elif char in ru_to_en:
            ru_hits += 1
    if en_hits >= MIN_HITS and en_hits >= ru_hits * RATIO:
        direction = "en_to_ru"
    elif ru_hits >= MIN_HITS and ru_hits >= en_hits * RATIO:
        direction = "ru_to_en"
    else:
        direction = None
    return direction, en_hits, ru_hits

# =============================================
# ОБРАБОТЧИК ГОРЯЧЕЙ КЛАВИШИ
# =============================================

# Эта функция инкапсулирует всю основную бизнес-логику:
# 1) сохраняем буфер
# 2) копируем выделенный текст
# 3) конвертируем его
# 4) вставляем обратно
# 5) восстанавливаем буфер

def handle_key_press():
    """Обрабатывает нажатие горячей клавиши"""
    # Сохраняем текущее содержимое буфера обмена, чтобы не потерять данные пользователя.
    # Важно: любые ошибки чтения буфера не должны уронить скрипт.
    try:
        original_clipboard = pyperclip.paste()
    except Exception:
        # Логируем исключение, чтобы понимать, почему буфер не читается
        logger.exception("Не удалось прочитать буфер обмена перед обработкой")
        # Если буфер недоступен, работаем с пустым значением как с безопасной базой.
        original_clipboard = ""

    try:
        # Кладём уникальный маркер в буфер ДО копирования, чтобы отличить отсутствие выделения
        marker = f"__LAYOUT_SWITCHER_MARKER__{time.time_ns()}__"
        try:
            pyperclip.copy(marker)
        except Exception:
            # Логируем, т.к. без маркера нельзя корректно проверить выделение
            logger.exception("Не удалось записать маркер в буфер обмена")
            # Если не удалось записать маркер, безопаснее выйти без вставки
            return
        # Отмечаем в логе установку маркера для отладки проблем с выделением
        logger.debug("Маркер буфера установлен")

        # Создаем экземпляр контроллера клавиатуры для Ctrl+C / Ctrl+V
        controller = keyboard.Controller()

        # Копируем выделенный текст (Ctrl+C)
        # Это единственный способ получить текущее выделение в активном приложении
        controller.press(keyboard.Key.ctrl)
        controller.tap('c')
        controller.release(keyboard.Key.ctrl)

        # Небольшая задержка нужна, чтобы буфер обмена успел обновиться
        time.sleep(0.15)

        # Читаем буфер после копирования и проверяем, что реально было выделение.
        # Если буфер остался маркером или пустой/не строка — считаем, что выделения нет.
        try:
            copied = pyperclip.paste()
        except Exception:
            # Логируем исключение чтения, чтобы видеть сбои буфера в рантайме
            logger.exception("Не удалось прочитать буфер обмена после Ctrl+C")
            copied = ""

        if not isinstance(copied, str) or copied.strip() == "" or copied == marker:
            # Важно: не вставляем и не переключаем раскладку, просто выходим.
            logger.info("Выделение не обнаружено или копирование не сработало")
            return

        # Определяем направление с порогом уверенности, чтобы не конвертировать случайный текст
        direction, en_hits, ru_hits = detect_conversion_direction(copied)
        # Логируем hits и направление для отладки спорных случаев
        logger.debug(
            "Направление конвертации: %s (en_hits=%d, ru_hits=%d)",
            direction,
            en_hits,
            ru_hits
        )
        if direction is None:
            # Если уверенности нет, пропускаем конвертацию и выходим
            logger.info(
                "Направление не определено (en_hits=%d, ru_hits=%d) — пропускаю конвертацию",
                en_hits,
                ru_hits
            )
            return

        # Конвертируем текст между раскладками
        converted_text = switch_layout(copied)
        # Пост-обработка двойных заглавных, не затрагивая раскладку системы
        converted_text, caps_fixed = fix_double_caps(converted_text)
        if caps_fixed > 0:
            logger.debug("Исправлено двойных заглавных слов: %d", caps_fixed)
        # Логируем успешную конвертацию для диагностики
        logger.debug("Конвертация выполнена, длина текста: %d", len(copied))

        # Вставляем конвертированный текст (Ctrl+V)
        # Сначала кладём конвертированный текст в буфер
        try:
            pyperclip.copy(converted_text)
        except Exception:
            # Логируем, т.к. без записи в буфер вставка невозможна
            logger.exception("Не удалось записать конвертированный текст в буфер обмена")
            # Если не удалось записать в буфер, дальше продолжать нельзя
            return
        time.sleep(0.15)
        controller.press(keyboard.Key.ctrl)
        controller.tap('v')
        controller.release(keyboard.Key.ctrl)

        # Задержка перед восстановлением буфера важна, чтобы вставка успела завершиться
        time.sleep(0.15)
    finally:
        # Восстанавливаем оригинальное содержимое буфера всегда, даже при ошибках.
        # Ошибки восстановления подавляем, чтобы не ронять слушатель.
        try:
            pyperclip.copy(original_clipboard)
        except Exception:
            # Логируем сбой восстановления, но не падаем
            logger.exception("Не удалось восстановить исходный буфер обмена")
            pass

# =============================================
# УПРАВЛЯЕМЫЙ СЛУШАТЕЛЬ ГОРЯЧЕЙ КЛАВИШИ
# =============================================

# Этот класс нужен, чтобы можно было стартовать/останавливать слушатель
# и ставить обработку на паузу (для управления из трея).

class HotkeyListener:
    """Управляемый слушатель Ctrl_L + Super_L + (x|c|с|ч) с поддержкой паузы"""

    def __init__(self):
        # Потокобезопасный флаг паузы: set() = пауза включена
        self._paused = threading.Event()
        # Внутренние флаги для отслеживания модификаторов
        self._ctrl_pressed = False
        self._super_pressed = False
        # Время последнего срабатывания нужно для debounce (антидребезга)
        self._last_trigger_time = 0.0
        # Слушатель создаём при старте, чтобы корректно управлять жизненным циклом
        self._listener = None

    def start(self):
        """Запускает слушатель хоткея в фоне"""
        if self._listener is not None:
            return
        # Создаём listener с привязкой к методам класса
        self._listener = keyboard.Listener(
            on_press=self._on_press,
            on_release=self._on_release
        )
        self._listener.start()

    def stop(self):
        """Останавливает слушатель хоткея"""
        if self._listener is None:
            return
        self._listener.stop()
        self._listener = None

    def join(self):
        """Блокирует поток до остановки слушателя (нужно для CLI-режима)"""
        if self._listener is not None:
            self._listener.join()

    def set_paused(self, paused: bool):
        """Включает или выключает паузу обработки хоткея"""
        if paused:
            self._paused.set()
            logger.info("Пауза включена")
        else:
            self._paused.clear()
            logger.info("Пауза снята")

    def is_paused(self):
        """Возвращает True, если обработка хоткея приостановлена"""
        return self._paused.is_set()

    def _on_press(self, key):
        # Отслеживаем только левый Ctrl, чтобы хоткей был строго по требованию
        if key == keyboard.Key.ctrl_l:
            self._ctrl_pressed = True
            return
        # Отслеживаем только левый Super (Cmd), чтобы хоткей был строго по требованию
        if key == keyboard.Key.cmd_l:
            self._super_pressed = True
            return
        # Срабатываем на кластер при активных Ctrl_L + Super_L и одной из триггерных клавиш
        if (
            self._ctrl_pressed
            and self._super_pressed
            and hasattr(key, "char")
            and key.char in TRIGGER_KEYS
        ):
            # Логируем факт детекта хоткея для отладки
            logger.debug("Hotkey detected: Ctrl_L + Super_L + cluster")
            now = time.monotonic()
            # Debounce 300 мс, чтобы не срабатывать несколько раз подряд
            if (now - self._last_trigger_time) >= 0.3:
                self._last_trigger_time = now
                # При паузе хоткей фиксируется, но обработка не выполняется
                if self._paused.is_set():
                    logger.info("Пауза включена — конвертация пропущена")
                    return
                handle_key_press()

    def _on_release(self, key):
        # Сбрасываем состояние Ctrl_L, чтобы избежать ложных срабатываний
        if key == keyboard.Key.ctrl_l:
            self._ctrl_pressed = False
            return
        # Сбрасываем состояние Super_L
        if key == keyboard.Key.cmd_l:
            self._super_pressed = False
            return

# =============================================
# ЗАПУСК СКРИПТА
# =============================================

# Вынесено в main(), чтобы запускать слушатель в CLI-режиме
# и оставлять управление жизненным циклом внутри одной функции

def parse_args():
    parser = argparse.ArgumentParser(description="Layout switcher debug options")
    parser.add_argument("--debug", action="store_true", help="Включить отладочные логи")
    return parser.parse_args()

def main():
    # Создаём управляемый слушатель, чтобы его можно было остановить извне
    listener = HotkeyListener()
    listener.start()

    # Логируем запуск скрипта для диагностики
    logger.info(
        "Системная раскладка НЕ меняется намеренно (из-за ограничений GNOME/IBus). "
        "Скрипт конвертирует только выделенный текст."
    )
    logger.info("Скрипт запущен. Используйте Ctrl_L + Super_L + (x|c|с|ч)")
    logger.info("Для выхода нажмите Ctrl+C в терминале.")

    # В CLI-режиме блокируем поток до остановки слушателя
    listener.join()


if __name__ == "__main__":
    args = parse_args()
    log_level = logging.DEBUG if args.debug else logging.INFO
    logging.basicConfig(level=log_level, format="%(asctime)s %(levelname)s %(message)s")
    main()
