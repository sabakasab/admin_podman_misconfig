#!/usr/bin/env bash
# Collect: HTTP GET /health from host
set -euo pipefail

http_ok=0
http_code=0
body=""

# curl may be missing on podman image — try curl then wget
raw=""
if command -v curl &>/dev/null; then
  raw="$(curl -sS -m 5 -w '\n%{http_code}' http://127.0.0.1:8080/health 2>/dev/null || true)"
elif command -v wget &>/dev/null; then
  body_tmp="$(wget -q -T 5 -O - http://127.0.0.1:8080/health 2>/dev/null || true)"
  raw="$(printf '%s\n200' "${body_tmp}")"
fi

if [[ -n "${raw}" ]]; then
  http_code="$(printf '%s' "${raw}" | tail -n1)"
  body="$(printf '%s' "${raw}" | sed '$d' | tr -d '\r' | sed -e 's/[[:space:]]*$//' | tr -d '\n')"
  if [[ "${http_code}" == "200" && "${body}" == "ok" ]]; then
    http_ok=1
  fi
fi

body_esc="${body//\\/\\\\}"
body_esc="${body_esc//\"/\\\"}"

# force decimal (avoid invalid JSON like 000)
http_code=$((${http_code:-0} + 0))

printf '{"http_ok":%s,"http_code":%s,"body":"%s"}\n' \
  "${http_ok}" "${http_code}" "${body_esc}"
