# Шаг 2. Запуск

В files/ есть compose.yml.draft и run.sh.draft — доведите запуск до рабочего состояния.

| Параметр | Значение |
|----------|----------|
| Имя контейнера | workshop-health |
| Образ | workshop-health:local |
| Publish | 8080:8080 |
| Состояние | running |

Удобно использовать podman-compose.

'podman ps --filter name=workshop-health'{{execute}}
