#!/usr/bin/env bash
# Final: image + container + HTTP
set -euo pipefail

image_ok=0
container_ok=0
http_ok=0

if podman image exists workshop-health:local &>/dev/null \
  || podman images --format '{{.Repository}}:{{.Tag}}' 2>/dev/null | grep -qx 'workshop-health:local'; then
  image_ok=1
fi

if podman container exists workshop-health &>/dev/null; then
  status="$(podman inspect workshop-health --format '{{.State.Status}}' 2>/dev/null || true)"
  publish_ok=0
  if podman port workshop-health 8080 2>/dev/null | grep -Eq ':8080$'; then
    publish_ok=1
  fi
  if [[ "${status}" == "running" && "${publish_ok}" == "1" ]]; then
    container_ok=1
  fi
fi

body=""
code=0
if command -v curl &>/dev/null; then
  raw="$(curl -sS -m 5 -w '\n%{http_code}' http://127.0.0.1:8080/health 2>/dev/null || true)"
  if [[ -n "${raw}" ]]; then
    code="$(printf '%s' "${raw}" | tail -n1)"
    body="$(printf '%s' "${raw}" | sed '$d' | tr -d '\r' | sed -e 's/[[:space:]]*$//' | tr -d '\n')"
  fi
fi
if [[ "${code}" == "200" && "${body}" == "ok" ]]; then
  http_ok=1
fi

printf '{"image_ok":%s,"container_ok":%s,"http_ok":%s}\n' \
  "${image_ok}" "${container_ok}" "${http_ok}"
