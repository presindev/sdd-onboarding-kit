# Failure-learning hook example (advisory only)

Suggests running the `failure-learning` skill when the same validation
command fails more than once in a session. Example only — **disabled by
default**, like every kit hook.

## Guarantee

This hook is strictly advisory:

- it **never writes memory** (global or project) — memory writes happen
  only through the failure-learning skill's mandatory confirmation prompt;
- it never edits project files; its only side effect is a counter file
  under the system temp directory (`$TMPDIR/sdd-failure-learning/`);
- it never blocks the tool call (always exits 0);
- it fails open with a warning when `jq` is missing.

## How it works

1. Wired to `PostToolUse` with matcher `Bash`.
2. Ignores everything except validation-style commands (the
   `watch_pattern` variable — adapt it to the project's real test/lint
   commands during onboarding).
3. Counts failures per session and command in a temp file.
4. On the second failure of the same command, emits
   `hookSpecificOutput.additionalContext` reminding Claude that the
   failure-learning skill exists. Nothing else.

## Installation (after explicit developer approval)

Copy `suggest-failure-learning.sh` into the target project (e.g.
`.claude/hooks/`), make it executable, and add to `.claude/settings.json`:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/suggest-failure-learning.sh"
          }
        ]
      }
    ]
  }
}
```

## Version note

The shape of the tool-result field in the hook's stdin JSON
(`tool_response` vs `tool_output`, `success`/`exit_code` markers) and the
event for failing commands (`PostToolUse` vs `PostToolUseFailure`) can vary
between Claude Code versions. The script tolerates both names and both
events, but verify against the installed version's hook documentation
before enabling — the kit-wide rule in `hooks/settings-snippets.md`
applies.

## Environment

Bash plus `jq` (Git Bash or WSL on Windows). Without `jq` the hook warns
and allows — it never blocks.
