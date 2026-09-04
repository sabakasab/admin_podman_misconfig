#!/usr/bin/env bash
# Collect: workshop-health:local image present
set -euo pipefail

image_ok=0
image_id=""

if podman image exists workshop-health:local &>/dev/null; then
  image_ok=1
  image_id="$(podman image inspect workshop-health:local --format '{{.Id}}' 2>/dev/null | head -c 12 || true)"
elif podman images --format '{{.Repository}}:{{.Tag}}' 2>/dev/null | grep -qx 'workshop-health:local'; then
  image_ok=1
  image_id="$(podman images -q workshop-health:local 2>/dev/null | head -1 || true)"
fi

printf '{"image_ok":%s,"image_id":"%s"}\n' "${image_ok}" "${image_id}"
