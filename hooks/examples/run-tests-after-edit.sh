#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
cd "$PROJECT_DIR"

if [[ -x "./scripts/run-tests.sh" ]]; then
  ./scripts/run-tests.sh
else
  echo "SDD hook warning: ./scripts/run-tests.sh not found or not executable." >&2
fi
