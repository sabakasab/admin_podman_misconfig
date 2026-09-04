#!/usr/bin/bash
# Prepare workspace: clone exercise materials from GitHub (HTTPS).
set -euo pipefail

REPO_URL="${REPO_URL:-https://github.com/sabakasab/admin_podman_misconfig.git}"
DEST="${DEST:-$HOME/admin_podman_misconfig}"

if [[ -d "${DEST}/.git" ]]; then
  git -C "${DEST}" fetch -q origin
  git -C "${DEST}" reset -q --hard origin/main
else
  rm -rf "${DEST}"
  git clone -q "${REPO_URL}" "${DEST}"
fi

cd "${DEST}"
echo "Workspace: ${DEST}"
ls -la files/
