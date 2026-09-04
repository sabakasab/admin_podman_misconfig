# Podman: починить health-сервис

Черновик упражнения SkillTrack (категория admin).

Окружение LXC: python-3.14 (Podman, podman-compose, Python 3.14).

Цель: образ workshop-health:local, контейнер workshop-health с publish 8080:8080, с хоста curl http://127.0.0.1:8080/health возвращает ok.
