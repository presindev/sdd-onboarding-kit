#!/usr/bin/env bash
set -euo pipefail

# Advisory-only failure-learning hook (example, disabled by default).
#
# Watches validation-style Bash commands; when the same command fails more
# than once in a session, it injects a reminder suggesting the
# failure-learning skill. It NEVER writes memory or project files — its only
# side effect is a counter file under the system temp directory. Any memory
# write must go through the skill's mandatory confirmation prompt.

input="$(cat)"

if ! command -v jq >/dev/null 2>&1; then
  echo "SDD hook warning: jq not found; failure-learning suggestion skipped." >&2
  exit 0
fi

# tr -d '\r': jq on Windows emits CRLF; a stray \r breaks comparisons.
tool_name=$(printf '%s' "$input" | jq -r '.tool_name // empty' | tr -d '\r')
[ "$tool_name" = "Bash" ] || exit 0

cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // empty' | tr -d '\r')
[ -n "$cmd" ] || exit 0

# Only watch validation-style commands. Adapt this pattern to the project's
# real test/lint/typecheck commands during onboarding.
watch_pattern='run-tests\.sh|run-lint\.sh|npm (run )?test|npx (vitest|jest)|pytest|go test|cargo test'
printf '%s' "$cmd" | grep -Eq "$watch_pattern" || exit 0

hook_event=$(printf '%s' "$input" | jq -r '.hook_event_name // "PostToolUse"' | tr -d '\r')

# Failure signal. On PostToolUseFailure the call already failed; on
# PostToolUse, look for a failure marker in the tool result. The result
# field name and shape can vary between Claude Code versions — verify
# against the installed version before enabling (see README.md).
if [ "$hook_event" = "PostToolUseFailure" ]; then
  failed="yes"
else
  failed=$(printf '%s' "$input" | jq -r '
    (.tool_response // .tool_output // {}) as $r
    | if ($r | type) != "object" then "no"
      elif ($r.success? == false) then "yes"
      elif ((($r.exit_code? // 0) | tonumber?) // 0) != 0 then "yes"
      else "no" end' | tr -d '\r')
fi
[ "$failed" = "yes" ] || exit 0

session_id=$(printf '%s' "$input" | jq -r '.session_id // "no-session"' | tr -d '\r')
cmd_hash=$(printf '%s' "$cmd" | cksum | awk '{print $1}')
state_dir="${TMPDIR:-/tmp}/sdd-failure-learning"
mkdir -p "$state_dir"
state_file="$state_dir/${session_id}-${cmd_hash}.count"

count=0
if [ -f "$state_file" ]; then
  count=$(cat "$state_file")
fi
count=$((count + 1))
printf '%s' "$count" > "$state_file"

# Suggest once per session and command: on the second failure only.
[ "$count" -eq 2 ] || exit 0

jq -n --arg cmd "$cmd" --arg event "$hook_event" '{
  hookSpecificOutput: {
    hookEventName: $event,
    additionalContext: ("The command `" + $cmd + "` has failed more than once in this session. If the repeated failure comes from a wrong assumption or a project convention, consider running the failure-learning skill to propose a reusable lesson. Advisory only: any memory write requires the developer to approve the exact entry text first.")
  }
}'
exit 0
