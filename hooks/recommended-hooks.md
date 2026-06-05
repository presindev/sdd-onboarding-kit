# Recommended SDD hooks

This file describes hooks that can be enabled in `.claude/settings.json` after developer approval.

## 1. Block implementation before approval

Purpose: prevent edits to source files when a task is only `pending`, `spec_draft` or `spec_ready`.

Recommended event:

- `PreToolUse`

Recommended matchers:

- `Edit`
- `Write`
- `MultiEdit`

Script:

```text
hooks/examples/block-implementation-before-approval.sh
```

## 2. Run tests after edits

Purpose: run project tests after relevant source edits.

Recommended event:

- `PostToolUse`

Recommended matchers:

- `Edit|Write|MultiEdit`

Script:

```text
hooks/examples/run-tests-after-edit.sh
```

## 3. Validate specs before status changes

Purpose: ensure `requirements.md`, `design.md` and `tasks.md` exist before moving to `spec_ready`.

Recommended event:

- `PreToolUse` or project task update workflow.

Script:

```text
hooks/examples/validate-spec-before-status-change.sh
```

## 4. Block destructive commands

Purpose: prevent accidental destructive shell commands.

Recommended event:

- `PreToolUse`

Recommended matcher:

- `Bash`

Examples of commands to block or confirm:

- `rm -rf`
- `git reset --hard`
- `git clean -fd`
- `drop database`
- direct edits to secrets or production configs.

## 5. Notify for human approval

Purpose: alert the developer when Claude stops at `spec_ready`.

Recommended event:

- `Stop`
- `Notification`

This is environment-specific and should be configured per OS/team.
