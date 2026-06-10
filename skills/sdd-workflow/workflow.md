# SDD workflow

This file contains the operational workflow for SDD tasks.

## 1. Select or create task

A task must have:

- ID;
- title;
- slug;
- description;
- `sdd` flag or equivalent policy;
- status;
- spec path;
- approval metadata.

If the developer describes a new feature informally, create a task entry before creating the spec.

## 2. Decide if SDD applies

Use project policy from `CLAUDE.md`.

If SDD does not apply, state why and follow the non-SDD workflow.

If SDD applies, continue.

## 3. Create spec

For a `pending` task, create:

```text
specs/<feature-slug>/requirements.html
specs/<feature-slug>/design.html
specs/<feature-slug>/tasks.html
specs/<feature-slug>/spec.css
specs/<feature-slug>/spec.js
```

Use `spec-format.md`.

Recommended order:

1. Requirements.
2. Design.
3. Tasks.
4. Requirement-to-test mapping.

## 4. Stop for approval

When the spec is complete:

1. Set status to `spec_ready`.
2. Summarize the spec.
3. Ask the developer to approve or request changes.
4. Do not implement.

## 5. Revise spec if requested

If the developer asks for changes:

1. Update spec files.
2. Record changed assumptions.
3. Keep status as `spec_draft` or `spec_ready` according to project policy.
4. Ask again for approval.

## 6. Implement approved spec

Only after approval:

1. Set status to `in_progress`.
2. Read `tasks.html`.
3. Execute tasks sequentially.
4. Add/update tests.
5. Run configured validation.
6. Mark completed tasks in `tasks.html` (add `class="done"` to the `<li class="task-item">`).
7. Set status to `review`.

## 7. Review

The reviewer validates:

- requirements implemented;
- tests cover requirements;
- design followed;
- conventions respected;
- validation commands pass;
- no unauthorized scope creep.

Write `review.html`.

## 8. Complete

If reviewer approves:

1. Set task status to `done`.
2. Append to `history.html`.
3. Include changed files and commands run.

If reviewer rejects:

1. Set status to `in_progress`, `spec_draft` or `blocked`.
2. List exact corrections.

## 9. History entry format

Append entries like:

Append to `history.html` using the entry format in `templates/history.html.template` (copy the HTML entry block).

## Workflow variant: intake from functional document

Use this variant when the source input is a functional document, PRD, ticket, user story, or informal feature description.

Flow:

```text
functional document
→ intake analysis
→ assumptions.html
→ open-questions.html
→ requirements.html
→ design.html
→ tasks.html
→ acceptance-tests.html
→ human approval
→ implementation
→ review

Rules:

1. Do not implement directly from the functional document.
2. If blocking questions exist, keep the task in spec_draft.
3. If only non-blocking questions or explicit assumptions exist, the task may move to spec_ready.
4. Only the developer may move the task to human_approved.