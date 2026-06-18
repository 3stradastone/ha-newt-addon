#!/usr/bin/env bash
set -e

OPTIONS=/data/options.json

PANGOLIN_ENDPOINT="$(jq -r '.pangolin_endpoint // ""' "${OPTIONS}")"
NEWT_ID="$(jq -r '.newt_id // ""' "${OPTIONS}")"
NEWT_SECRET="$(jq -r '.newt_secret // ""' "${OPTIONS}")"
LOG_LEVEL="$(jq -r '.log_level // "INFO"' "${OPTIONS}")"

if [ -z "${PANGOLIN_ENDPOINT}" ] || [ -z "${NEWT_ID}" ] || [ -z "${NEWT_SECRET}" ]; then
  echo "[newt] ERROR: pangolin_endpoint, newt_id and newt_secret are all required."
  echo "[newt] Create a Site in the Pangolin dashboard to generate the ID/secret."
  exit 1
fi

echo "[newt] Starting Newt -> ${PANGOLIN_ENDPOINT}"

# newt reads these from the environment (no flags needed).
export PANGOLIN_ENDPOINT NEWT_ID NEWT_SECRET LOG_LEVEL

exec newt
