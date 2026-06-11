# Recommended SDD hooks

This file describes hooks that can be enabled in `.claude/settings.json` after developer approval.

## 1. Block implementation before approval

Purpose: prevent edits to source files when a task is only `pending`, `spec_draft` or `spec_ready`.

Recommended event:

- `PreToolUse`

Recommended matchers:

- `Edit`
- `Write`

Script:

```text
hooks/examples/block-implementation-before-approval.sh
```

## 2. Run tests after edits

Purpose: run project tests after relevant source edits.

Recommended event:

- `PostToolUse`

Recommended matchers:

- `Edit|Write`

Script:

```text
hooks/examples/run-tests-after-edit.sh
```

## 3. Validate specs before status changes

Purpose: ensure `requirements.html`, `design.html` and `tasks.html` exist before a task can move to `spec_ready`.

The script reads the PreToolUse JSON from stdin, acts only when the tool call edits `tasks.json` and the proposed content contains `spec_ready`, then verifies the three core spec files exist for the affected feature slug(s). State is read from `tasks.json` and the tool input via `jq`, not from spec file content. It fails open (warning, exit 0) when `jq` is unavailable.

Recommended event:

- `PreToolUse`

Recommended matchers:

- `Edit|Write`

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

## 6. Suggest failure learning (advisory only)

Purpose: when the same validation command fails more than once in a session, remind Claude that the `failure-learning` skill exists. The hook never writes memory and never blocks — any memory write goes through the skill's mandatory confirmation prompt.

Recommended event:

- `PostToolUse`

Recommended matcher:

- `Bash`

Script and details:

```text
hooks/examples/failure-learning/suggest-failure-learning.sh
hooks/examples/failure-learning/README.md
```

Only useful if the `failure-learning` skill pack is installed. Adapt the script's `watch_pattern` to the project's real test/lint commands before enabling.
