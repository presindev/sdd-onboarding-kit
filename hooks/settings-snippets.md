# Hook settings snippets

These snippets are examples only. Do not paste them into `.claude/settings.json` without adapting paths, commands and matchers to the target project.

## Post-edit validation example

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "./scripts/run-tests.sh"
          }
        ]
      }
    ]
  }
}
```

## Pre-edit approval guard example

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "./scripts/block-implementation-before-approval.sh"
          }
        ]
      }
    ]
  }
}
```

## Failure-learning suggestion example (advisory only)

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

The script never writes memory and never blocks; see `hooks/examples/failure-learning/README.md`.

## Pre-compact capture example (advisory)

```json
{
  "hooks": {
    "PreCompact": [
      {
        "matcher": "manual",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/pre-compact-capture.sh"
          }
        ]
      }
    ],
    "SessionStart": [
      {
        "matcher": "compact",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/post-compact-reorient.sh"
          }
        ]
      }
    ]
  }
}
```

See `hooks/examples/pre-compact-capture/README.md`; gate mode goes on the `manual` matcher only.

## Targeted validation example (advisory)

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

Adapt the script's `RULES` table first; see `hooks/examples/targeted-validation/README.md`.

## Spec-drift example (warn by default, block opt-in)

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/spec-drift.sh"
          }
        ]
      }
    ]
  }
}
```

Requires `scope` globs on active tasks in `tasks.json`; see `hooks/examples/spec-drift/README.md`.

## Subagent lifecycle example

```json
{
  "hooks": {
    "SubagentStart": [
      {
        "matcher": "implementer",
        "hooks": [
          {
            "type": "command",
            "command": "./scripts/validate-sdd-structure.sh"
          }
        ]
      }
    ]
  }
}
```

## Warning

Hook JSON shape, event names (e.g. `SubagentStart`) and tool names used in matchers can evolve with Claude Code versions. During onboarding, Claude Code should verify the current local documentation or installed version before finalizing `.claude/settings.json`.
