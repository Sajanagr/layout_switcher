#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
./gnome_input_source.py

Утилиты для работы с раскладкой в GNOME Shell (per-window/per-app).
Реализовано через gdbus → org.gnome.Shell.Eval → InputSourceManager.

Важно:
- Работает в GNOME на X11/Wayland при наличии org.gnome.Shell.
- Это влияет на активное окно (как Alt+Shift), а не на глобальный gsettings.
"""

from __future__ import annotations

import subprocess
import logging
import re
from typing import Optional

logger = logging.getLogger("gnome_input_source")


def _shell_eval(js_expr: str) -> str:
    """
    Выполняет JS-выражение в контексте GNOME Shell через org.gnome.Shell.Eval.
    Возвращает сырой stdout (строку).
    """
    cmd = [
        "gdbus", "call", "--session",
        "--dest", "org.gnome.Shell",
        "--object-path", "/org/gnome/Shell",
        "--method", "org.gnome.Shell.Eval",
        js_expr,
    ]
    try:
        res = subprocess.run(
            cmd,
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
        )
        return res.stdout.strip()
    except subprocess.CalledProcessError as e:
        logger.error("GNOME Shell Eval error: %s", (e.stderr or "").strip())
        raise


def _parse_eval_result(raw: str) -> str:
    """
    gdbus обычно возвращает: (true, 'RESULT')
    Нам нужно вытащить RESULT.
    """
    # Пример raw: "(true, '1')"
    m = re.search(r"\(true,\s*'(.+)'\)", raw)
    if not m:
        # Бывает "(false, '...')" или другой формат — вернем как есть для диагностики
        return raw
    return m.group(1)


def get_active_layout_index() -> Optional[int]:
    """
    Возвращает индекс активной раскладки для текущего окна (0,1,2...),
    либо None, если не удалось определить.
    """
    raw = _shell_eval(
        "imports.ui.status.keyboard.getInputSourceManager().currentSource.index"
    )
    val = _parse_eval_result(raw)

    try:
        return int(val)
    except ValueError:
        logger.warning("Не удалось распарсить индекс раскладки из: %r", raw)
        return None


def set_active_layout_index(index: int) -> bool:
    """
    Активирует раскладку по индексу для текущего окна.
    Возвращает True при успехе.
    """
    if index < 0:
        raise ValueError("index должен быть >= 0")

    raw = _shell_eval(
        f"imports.ui.status.keyboard.getInputSourceManager().inputSources[{index}].activate(); 'ok'"
    )
    val = _parse_eval_result(raw)
    return val == "ok"
