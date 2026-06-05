#!/usr/bin/env bash
set -euo pipefail

# Example hook script.
# Adapt this script to the project's real task storage and source directories.
# This script assumes local tasks.json and blocks edits when there is an active SDD task
# without human approval.

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
TASKS_FILE="$PROJECT_DIR/tasks.json"

if [[ ! -f "$TASKS_FILE" ]]; then
  exit 0
fi

# If jq is unavailable, warn but do not block. Change this policy if desired.
if ! command -v jq >/dev/null 2>&1; then
  echo "SDD hook warning: jq not found; cannot enforce approval guard." >&2
  exit 0
fi

ACTIVE_UNAPPROVED=$(jq '[.tasks[]? | select(.sdd == true and (.status == "pending" or .status == "spec_draft" or .status == "spec_ready"))] | length' "$TASKS_FILE")

if [[ "$ACTIVE_UNAPPROVED" -gt 0 ]]; then
  echo "Blocked by SDD policy: there is an SDD task awaiting spec approval. Do not edit implementation files until status is human_approved or in_progress." >&2
  exit 2
fi

exit 0
