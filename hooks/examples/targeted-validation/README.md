# Targeted validation hook example (advisory)

After an edit, suggests — or optionally runs — the targeted check that
matches the changed file, instead of the full suite: frontend changes →
frontend checks, backend changes → backend tests, schema changes →
migration checks. Example only — **disabled by default**, like every kit
hook.

## Guarantee

- Never blocks the edit (PostToolUse fires after the tool already ran).
- Writes nothing to the project; the only side effect is a
  suggested-once marker under the system temp directory.
- Fails open with a warning when `jq` is missing.

## How it works

1. Wired to `PostToolUse` with matcher `Edit|Write`.
2. Matches the edited file's project-relative path against the `RULES`
   table (`pattern :: command`, first match wins). The shipped rules are
   placeholders — **adapt patterns and commands to the project during
   onboarding, and never map a command that was not confirmed** (the
   run-and-verify recipe and `questions.md` §7 are the sources).
3. `suggest` mode (default): injects `additionalContext` naming the
   matching check, once per session per command.
4. `run` mode (`VALIDATION_MODE=run`): executes the matching command
   synchronously and reports pass/fail plus the last 20 output lines.
   Keep mapped commands fast and side-effect-free — a command that
   rewrites files (formatter, generator) would make this hook mutating
   and needs its own explicit opt-in.

## Installation (after explicit developer approval)

Copy `targeted-validation.sh` into the target project (e.g.
`.claude/hooks/`), adapt the `RULES` table, make it executable, and add
to `.claude/settings.json`:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/targeted-validation.sh"
          }
        ]
      }
    ]
  }
}
```

## Version note

The `tool_input` field names (`file_path`, `notebook_path`) and the
`additionalContext` output shape can evolve between Claude Code versions.
Verify against the installed version's hook documentation before
enabling — the kit-wide rule in `hooks/settings-snippets.md` applies.

## Environment

Bash plus `jq` (Git Bash or WSL on Windows). Without `jq` the hook warns
and allows — it never blocks.
