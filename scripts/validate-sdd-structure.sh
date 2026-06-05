#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
cd "$PROJECT_DIR"

missing=0

check_file() {
  local path="$1"
  if [[ ! -f "$path" ]]; then
    echo "Missing file: $path" >&2
    missing=1
  fi
}

check_dir() {
  local path="$1"
  if [[ ! -d "$path" ]]; then
    echo "Missing directory: $path" >&2
    missing=1
  fi
}

check_file "CLAUDE.md"
check_dir ".claude/agents"
check_file ".claude/agents/leader.md"
check_file ".claude/agents/spec-author.md"
check_file ".claude/agents/implementer.md"
check_file ".claude/agents/reviewer.md"
check_dir ".claude/skills/sdd-workflow"
check_file ".claude/skills/sdd-workflow/SKILL.md"
check_file ".claude/skills/sdd-workflow/workflow.md"
check_file ".claude/skills/sdd-workflow/spec-format.md"
check_file ".claude/skills/sdd-workflow/task-state-machine.md"
check_file ".claude/skills/sdd-workflow/review-checklist.md"
check_dir "specs"
check_file "tasks.json"
check_file "history.md"
check_dir "scripts"
check_file "scripts/run-tests.sh"
check_file "scripts/run-lint.sh"

if [[ "$missing" -ne 0 ]]; then
  echo "SDD structure validation failed." >&2
  exit 1
fi

if grep -R "{{[A-Z0-9_]*}}" CLAUDE.md .claude 2>/dev/null; then
  echo "Unresolved template placeholders found." >&2
  exit 1
fi

echo "SDD structure validation passed."
