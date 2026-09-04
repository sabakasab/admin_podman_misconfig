#!/usr/bin/env bash
# Collect: container workshop-health running with 8080:8080
set -euo pipefail

exists=0
running=0
name_ok=0
publish_ok=0
status=""

if podman container exists workshop-health &>/dev/null; then
  exists=1
  name_ok=1
  status="$(podman inspect workshop-health --format '{{.State.Status}}' 2>/dev/null || true)"
  if [[ "${status}" == "running" ]]; then
    running=1
  fi
  # Accept hostPort 8080 -> containerPort 8080 (tcp)
  ports="$(podman inspect workshop-health --format '{{json .NetworkSettings.Ports}}' 2>/dev/null || echo '{}')"
  if printf '%s' "${ports}" | grep -Eq '"8080/tcp".*"HostPort":"8080"' \
    || podman port workshop-health 8080 2>/dev/null | grep -Eq ':8080$'; then
    publish_ok=1
  fi
fi

printf '{"exists":%s,"running":%s,"name_ok":%s,"publish_ok":%s,"status":"%s"}\n' \
  "${exists}" "${running}" "${name_ok}" "${publish_ok}" "${status}"
