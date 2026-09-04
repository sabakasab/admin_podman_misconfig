## Задача

Нужно поднять health-сервис в Podman по материалам из files/.

Итог:

1. Образ workshop-health:local
2. Контейнер workshop-health с пробросом 8080:8080
3. С хоста: curl -sf http://127.0.0.1:8080/health — тело ok

Проверки смотрят состояние системы.
