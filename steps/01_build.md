# Шаг 1. Инициализация, приложение и образ

Подготовьте workspace:

'./initTask.sh'{{execute}}

Материалы окажутся в ~/admin_podman_misconfig (черновики в подкаталоге files/).

Нужен образ с тегом workshop-health:local. Сервис внутри должен отвечать на /health телом ok и слушать порт 8080 так, чтобы его можно было пробросить на хост.

Соберите образ из каталога files/ в workspace (имя итогового Containerfile и способ сборки — на ваше усмотрение).

'podman images workshop-health:local'{{execute}}
