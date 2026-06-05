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

## Hook modes

### Advisory

The hook prints a warning but does not block.

Use for early adoption.

### Blocking

The hook exits non-zero or returns a block decision.

Use for mature rules such as preventing implementation before approval.

### Async

The hook runs in the background.

Use for slow validations or notifications.

## Project-specific requirement

Before enabling a hook, Claude Code must know:

- event;
- matcher;
- command;
- whether it blocks;
- what files it reads;
- what false positives are acceptable.
