# Сделать скрипт исполняемым | Make the script executable
chmod +x ~/projects/my/layout_switcher/start.sh

# Включить linger для пользователя (чтобы user-сервисы работали без активной сессии)
# Enable linger for user (so user services work without active session)
sudo loginctl enable-linger $USER

# Перезагрузить конфигурацию user services | Reload user services configuration
systemctl --user daemon-reload

# Включить автозагрузку | Enable autostart
systemctl --user enable layout_switcher.service

# Запустить сервис | Start the service
systemctl --user start layout_switcher.service

# Проверить статус | Check status
systemctl --user status layout_switcher.service

# Дополнительные команды | Additional commands:

# Проверить статус linger | Check linger status
loginctl show-user $USER | grep Linger

# Отключить linger | Disable linger
sudo loginctl disable-linger $USER

# Остановить сервис | Stop the service
systemctl --user stop layout_switcher.service

# Перезапустить сервис | Restart the service
systemctl --user restart layout_switcher.service

# Посмотреть логи в реальном времени | View logs in real-time
journalctl --user -u layout_switcher.service -f

# Посмотреть последние логи | View recent logs
journalctl --user -u layout_switcher.service -n 50

# Отключить автозагрузку | Disable autostart
systemctl --user disable layout_switcher.service

# Проверить, включен ли автозапуск | Check if autostart is enabled
systemctl --user is-enabled layout_switcher.service


Что дает linger 
(для данного случая может  и не очень актуально, но уж очень часто 
и трудноотлавливаемые ошибки без него встречаются, так что напоминание):

Linger позволяет user-сервисам работать даже когда пользователь 
не авторизован в системе. Это особенно полезно для:
- Сервисов, которые должны работать постоянно
- Автозапуска при загрузке системы
- Фоновых процессов, не зависящих от графической сессии
- Серверных приложений, работающих от пользователя

What linger provides:

Linger allows user services to run even when the user is not logged 
into the system. This is especially useful for:
- Services that need to run continuously
- Autostart during system boot
- Background processes independent of the graphical session
- Server applications running under a user account
