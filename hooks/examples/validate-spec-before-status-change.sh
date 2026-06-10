#!/usr/bin/env bash
# Validates that the three core spec files exist for a feature before allowing
# a status change to spec_ready.
# State is read from tasks.json (via jq if available), not from spec file content.
# Usage: $0 <feature-slug>
set -euo pipefail

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
FEATURE_SLUG="${1:-}"

if [[ -z "$FEATURE_SLUG" ]]; then
  echo "Usage: $0 <feature-slug>" >&2
  exit 2
fi

SPEC_DIR="$PROJECT_DIR/specs/$FEATURE_SLUG"

missing=0
for file in requirements.html design.html tasks.html; do
  if [[ ! -s "$SPEC_DIR/$file" ]]; then
    echo "Missing required spec file: $SPEC_DIR/$file" >&2
    missing=1
  fi
done

if [[ "$missing" -ne 0 ]]; then
  exit 2
fi

# If jq is available, also check that tasks.json does not show a blocking state
# for this feature (status still pending or spec_draft when we expect spec_ready).
if command -v jq &>/dev/null && [[ -f "$PROJECT_DIR/tasks.json" ]]; then
  status=$(jq -r --arg slug "$FEATURE_SLUG" \
    '.tasks[] | select(.slug == $slug) | .status // empty' \
    "$PROJECT_DIR/tasks.json" 2>/dev/null | head -1)
  if [[ -n "$status" && "$status" == "pending" ]]; then
    echo "Task $FEATURE_SLUG is still 'pending' in tasks.json — spec files not yet assigned." >&2
    exit 2
  fi
fi

exit 0
