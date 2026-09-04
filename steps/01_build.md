# Шаг 1. Приложение и образ

В files/ лежат исходники сервиса и Containerfile.draft.

Нужен образ с тегом workshop-health:local. Сервис внутри должен отвечать на /health телом ok и слушать порт 8080 так, чтобы его можно было пробросить на хост.

Соберите образ из каталога files/ (имя итогового Containerfile и способ сборки — на ваше усмотрение).

'podman images workshop-health:local'{{execute}}
