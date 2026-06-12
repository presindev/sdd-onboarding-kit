#!/usr/bin/env bash
set -euo pipefail

# Targeted validation hook (example, disabled by default).
#
# After an edit, map the changed file to a targeted check instead of the
# full suite: frontend changes -> frontend checks, backend changes ->
# backend tests, schema changes -> migration checks. Wired to PostToolUse
# with matcher Edit|Write. Never blocks the edit.
#
# Modes (VALIDATION_MODE environment variable, default below):
#   suggest (default) - advisory: inject a reminder naming the matching
#                       check. Suggested once per session per command.
#   run               - execute the matching check synchronously and
#                       report the result. Slow checks will delay the
#                       session; keep the mapped commands fast and
#                       side-effect-free (this hook is classified
#                       advisory because the edit is never blocked, but a
#                       mapped command that rewrites files would make it
#                       mutating — do not map formatters or generators
#                       here without explicit opt-in).

VALIDATION_MODE="${VALIDATION_MODE:-suggest}"

# "path-pattern (extended regex) :: command" — first match wins.
# EXAMPLES ONLY: replace patterns and commands with the project's real
# ones during onboarding. Never map a command that was not confirmed.
RULES=(
  '^(src/)?(frontend|components|pages|ui)/|\.(tsx|jsx|css|scss)$ :: npm run test:frontend'
  '^(src/)?(backend|server|api)/ :: npm run test:backend'
  '^(db/)?(migrations|schema)/ :: npm run check:migrations'
)

input="$(cat)"

if ! command -v jq >/dev/null 2>&1; then
  echo "SDD hook warning: jq not found; targeted validation skipped." >&2
  exit 0
fi

# tr -d '\r': jq on Windows emits CRLF; a stray \r breaks pattern matching.
file_path=$(printf '%s' "$input" | jq -r '.tool_input.file_path // .tool_input.notebook_path // empty' | tr -d '\r')
[ -n "$file_path" ] || exit 0

project_dir="${CLAUDE_PROJECT_DIR:-$(pwd)}"
rel_path="${file_path#"$project_dir"/}"

cmd=""
for rule in "${RULES[@]}"; do
  pattern="${rule%% :: *}"
  candidate="${rule##* :: }"
  if printf '%s' "$rel_path" | grep -Eq "$pattern"; then
    cmd="$candidate"
    break
  fi
done
[ -n "$cmd" ] || exit 0

if [ "$VALIDATION_MODE" = "run" ]; then
  result="passed"
  output=$(cd "$project_dir" && bash -c "$cmd" 2>&1) || result="FAILED"
  tail_output=$(printf '%s' "$output" | tail -n 20)
  jq -n --arg cmd "$cmd" --arg result "$result" --arg out "$tail_output" --arg f "$rel_path" '{
    hookSpecificOutput: {
      hookEventName: "PostToolUse",
      additionalContext: ("Targeted check for `" + $f + "`: `" + $cmd + "` " + $result + ".\n" + $out)
    }
  }'
  exit 0
fi

# suggest mode: once per session per command.
session_id=$(printf '%s' "$input" | jq -r '.session_id // "no-session"' | tr -d '\r')
cmd_hash=$(printf '%s' "$cmd" | cksum | awk '{print $1}')
state_dir="${TMPDIR:-/tmp}/sdd-targeted-validation"
mkdir -p "$state_dir"
state_file="$state_dir/${session_id}-${cmd_hash}.suggested"
[ -f "$state_file" ] && exit 0
: > "$state_file"

jq -n --arg cmd "$cmd" --arg f "$rel_path" '{
  hookSpecificOutput: {
    hookEventName: "PostToolUse",
    additionalContext: ("`" + $f + "` changed. The targeted check for this area is `" + $cmd + "` — consider running it before moving on (cheaper than the full suite).")
  }
}'
exit 0
