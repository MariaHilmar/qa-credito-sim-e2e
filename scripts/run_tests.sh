#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

if [[ -f .env.local ]]; then
  set -a
  # shellcheck disable=SC1091
  source .env.local
  set +a
fi

TAGS="${1:-}"
SUITE="${2:-tests/}"

ROBOT_ARGS=(
  --pythonpath libraries
  --pythonpath variables
  --outputdir results
  --xunit results/junit.xml
)

if [[ -n "$TAGS" ]]; then
  ROBOT_ARGS+=(--include "$TAGS")
fi

ROBOT_ARGS+=("$SUITE")

if [[ -x .venv/bin/robot ]]; then
  .venv/bin/robot "${ROBOT_ARGS[@]}"
else
  robot "${ROBOT_ARGS[@]}"
fi
