# Required onboarding questions

Claude Code must use this file to ask the developer about project-specific SDD decisions.

Ask only unanswered questions. If the repository already provides a reliable answer, state the inferred answer and ask for confirmation only if the decision is risky.

## 1. Scope of SDD

1. Should SDD apply to every feature, or only tasks explicitly marked with `sdd: true`?
2. Which kinds of tasks are too small for SDD?
3. Should bug fixes use the same SDD flow, a lighter flow, or no SDD?
4. Should documentation-only changes require specs?
5. Should emergency/hotfix work bypass SDD? If yes, how should it be marked?

## 2. Human approval policy

1. Is human approval mandatory before implementation?
2. Should Claude stop after creating `requirements.md`, `design.md`, and `tasks.md`?
3. Who approves specs: the current developer, a reviewer, or a team process?
4. Can Claude revise specs after feedback without resetting the task?
5. Should Claude be allowed to continue automatically after approval is recorded in `tasks.json`?

## 3. Requirements format

Choose one default format:

1. EARS: `When <trigger>, the system shall <response>`.
2. User stories with acceptance criteria.
3. Given/When/Then scenarios.
4. Plain numbered requirements.
5. Project-specific format.

Additional questions:

- Should every requirement map to at least one test?
- Should non-functional requirements be recorded separately?
- Should edge cases and error states be mandatory in every spec?

## 4. Design format

1. Should `design.md` include exact files/classes/functions to modify?
2. Should Claude propose alternatives before selecting a design?
3. Should architecture impacts be mandatory?
4. Should database/schema/API changes require an explicit migration section?
5. Should performance, security, accessibility or observability be mandatory sections?

## 5. Task format and storage

Where should task state live?

1. Local `tasks.json`.
2. Local Markdown board.
3. GitHub Issues.
4. Linear.
5. Jira.
6. Another tracker.

If using local storage:

- What task ID format should be used?
- Should task slugs be generated from titles?
- Should completed tasks move to `history.md`?

If using an external tracker:

- Should local specs still be created under `specs/`?
- Which statuses in the tracker map to SDD statuses?
- Should Claude update the external tracker automatically?

## 6. State machine

Default proposed statuses:

```text
pending → spec_draft → spec_ready → human_approved → in_progress → review → done
```

Questions:

1. Do you want these exact statuses?
2. Do you want a `rejected` status?
3. Do you want a `blocked` status?
4. Do you want `implemented` separate from `review`?
5. Who is allowed to move `spec_ready` to `human_approved`?

## 7. Tests and validation

1. What command runs all tests?
2. What command runs targeted tests?
3. What command runs lint?
4. What command runs typecheck?
5. What command runs formatting?
6. Should tests be written before implementation, during implementation, or after implementation?
7. Should reviewer reject code if no tests were added?
8. Should a task ever be marked `done` with failing tests?

## 8. Git policy

1. Should Claude create one branch per SDD feature?
2. What branch naming convention should be used?
3. Should Claude commit after each task, after each spec, or only at the end?
4. Should commit messages reference task IDs?
5. Should Claude open pull requests?
6. Should Claude avoid git operations entirely unless explicitly requested?

## 9. Hooks

Ask before enabling hooks.

Potential hooks:

1. Block implementation before spec approval.
2. Run tests after code edits.
3. Run lint/typecheck after code edits.
4. Prevent editing protected files.
5. Block destructive shell commands.
6. Validate task state transitions.
7. Notify when Claude is waiting for human approval.

Questions:

- Which hooks should be enabled now?
- Which should remain as examples only?
- Should hooks fail closed or warn only?

## 10. MCPs

Ask before configuring MCPs.

Possible MCP integrations:

1. GitHub: issues, pull requests, repository metadata.
2. Linear: project/task management.
3. Jira: enterprise task management.
4. Notion/Confluence/Google Drive: documentation.
5. Memory: persistent decisions and architecture notes.
6. Database/schema explorer.
7. Monitoring/observability systems.

Questions:

- Which external systems should Claude Code access?
- Are credentials already configured?
- Should MCPs be project-scoped or user-scoped?
- Should external content be treated as untrusted until reviewed?

## 11. Protected files and boundaries

1. Are there files Claude must not edit?
2. Are there directories that require explicit approval before changes?
3. Are migrations, infrastructure, secrets or deployment configs protected?
4. Should generated files be excluded from SDD review?
5. Should Claude avoid modifying public APIs without explicit approval?

## 12. Documentation and history

1. Should every completed task append to `history.md`?
2. Should architectural decisions be stored in `docs/adr/`?
3. Should specs remain permanently, or be archived after completion?
4. Should rejected design options be recorded?
5. Should Claude maintain a changelog?

## 13. Team conventions

1. What language should project docs use?
2. What coding style should Claude follow?
3. Are there naming conventions?
4. Are there testing conventions?
5. Are there review conventions?
6. Are there security or compliance rules?
