# Hook settings snippets

These snippets are examples only. Do not paste them into `.claude/settings.json` without adapting paths, commands and matchers to the target project.

## Post-edit validation example

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write|MultiEdit",
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
        "matcher": "Edit|Write|MultiEdit",
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

Hook JSON shape can evolve with Claude Code versions. During onboarding, Claude Code should verify the current local documentation or installed version before finalizing `.claude/settings.json`.
