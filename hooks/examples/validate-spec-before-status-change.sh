#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
FEATURE_SLUG="${1:-}"

if [[ -z "$FEATURE_SLUG" ]]; then
  echo "Usage: $0 <feature-slug>" >&2
  exit 2
fi

SPEC_DIR="$PROJECT_DIR/specs/$FEATURE_SLUG"

missing=0
for file in requirements.md design.md tasks.md; do
  if [[ ! -s "$SPEC_DIR/$file" ]]; then
    echo "Missing required spec file: $SPEC_DIR/$file" >&2
    missing=1
  fi
done

if [[ "$missing" -ne 0 ]]; then
  exit 2
fi

exit 0
