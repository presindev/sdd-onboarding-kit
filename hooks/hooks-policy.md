# Hooks policy for the SDD harness

Hooks are optional but useful for enforcing deterministic workflow constraints.

Do not enable hooks without explicit developer approval.

## Why hooks matter

Prompts and skills guide Claude. Hooks can enforce rules regardless of whether Claude remembers them.

Use hooks for rules like:

- block implementation before spec approval;
- block destructive shell commands;
- run tests or lint after edits;
- validate task state transitions;
- notify when human approval is needed.

## Recommended rollout

1. Start with no hooks enabled.
2. Install hook scripts as examples.
3. Ask the developer which hooks to enable.
4. Enable warning-only mode first where possible.
5. Move to blocking mode after the team trusts the workflow.

## Risk

Hooks can block legitimate work if they are too broad. Keep them small, testable and project-specific.

## Environment requirements

The example hook scripts are bash and rely on `jq` for reading hook JSON and `tasks.json`. On Windows this means Git Bash (or WSL) plus `jq` installed and on `PATH`. The examples fail open — they warn and allow the action — when `jq` is missing; switch them to fail closed only if the developer explicitly accepts that hooks will block work on machines without `jq`.

## Safety classification

Every hook in the kit — and any hook added during onboarding — is classified by its highest-risk behavior:

### Advisory

Observes and suggests. Never blocks a tool call, never writes project files or memory (a temp-directory counter at most). Safe to enable first.

### Blocking

Can stop a tool call (non-zero exit or a deny decision). Writes nothing. Enable once the team trusts the rule; prefer starting the same script in its warn mode where one exists.

### Mutating

Runs commands that change files or state (formatters that rewrite code, generators, anything with side effects beyond reading). **The kit ships no mutating hook.** Adding one requires explicit opt-in: the developer must approve it knowing exactly what it changes, and the hook's README must document every side effect.

### Dangerous

Touches external systems, credentials, git history, deployments, or production data. **The kit ships none and recommends against them.** If a project insists, the approval must be explicit and recorded (e.g. in `decisions/workflow-decisions.md`), and the hook must be scoped as narrowly as possible.

A hook is listed under its highest applicable class: a hook that suggests by default but can be switched to block is documented under both modes. Delivery can additionally be async (run in the background) for slow validations or notifications — async does not change the classification.

## Classification of the kit's example hooks

All of these are **examples, disabled by default**. None is enabled by installing the kit.

| Hook | Class | Notes |
|---|---|---|
| `block-implementation-before-approval.sh` | Blocking | Exit 2 before approval; spec/harness files always allowed. |
| `run-tests-after-edit.sh` | Advisory | Runs the configured test command after edits; never blocks. |
| `validate-spec-before-status-change.sh` | Blocking | Blocks `spec_ready` without the three core spec files. |
| `failure-learning/suggest-failure-learning.sh` | Advisory | Suggests the failure-learning skill; never writes memory. |
| `pre-compact-capture/` | Advisory | Reminds before compaction that durable state belongs in artifacts; never blocks, never writes. |
| `targeted-validation/` | Advisory | Suggests (default) or runs targeted checks for changed files; never blocks. |
| `spec-drift/` | Blocking (opt-in) / Advisory (default) | `DRIFT_MODE=warn` warns; `DRIFT_MODE=block` blocks edits outside the approved task scope. |

## Project-specific requirement

Before enabling a hook, Claude Code must know:

- event;
- matcher;
- command;
- whether it blocks;
- what files it reads;
- what false positives are acceptable.
