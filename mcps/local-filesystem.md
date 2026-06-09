# Local filesystem storage

The minimum SDD harness does not require external MCPs.

Use local files when:

- the project is small or early-stage;
- the team wants everything versioned in git;
- no external tracker is configured;
- onboarding should be simple;
- the developer wants to inspect all agent state directly.

## Local files

```text
tasks.json
specs/<feature-slug>/requirements.html
specs/<feature-slug>/design.html
specs/<feature-slug>/tasks.html
specs/<feature-slug>/review.html
history.html
```

## Advantages

- transparent;
- versionable;
- easy to diff;
- no credentials required;
- portable between machines;
- easy for Claude Code to read.

## Limitations

- no shared status board unless committed;
- no notifications;
- weaker integration with team planning;
- requires discipline around status updates.
