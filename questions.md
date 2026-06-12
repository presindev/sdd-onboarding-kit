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
2. Should Claude stop after creating `requirements.html`, `design.html`, and `tasks.html`?
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

1. Should `design.html` include exact files/classes/functions to modify?
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
- Should completed tasks move to `history.html`?

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
- Does every development environment have bash and `jq` available (on Windows: Git Bash or WSL)? If not, should hooks fail open (warn and allow) or fail closed (block) when `jq` is missing?

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

1. Should every completed task append to `history.html`?
2. Where should architectural decisions be recorded? (Detailed in §17.)
3. Should specs remain permanently, or be archived after completion?
4. Should rejected design options be recorded? (Detailed in §17.)
5. Should Claude maintain a changelog?
6. Where should the project map live: `.claude/context/project-map.md`
   (default, harness-internal) or `docs/project-map.md` (visible in docs)?
7. Should the project map be generated during onboarding (default), or
   deferred as a recorded TODO?

## 13. Team conventions

1. What language should project docs use?
2. What coding style should Claude follow?
3. Are there naming conventions?
4. Are there testing conventions?
5. Are there review conventions?
6. Are there security or compliance rules?

## 14. Optional skill packs

The core `sdd-workflow` skill is always installed. The packs under
`skills/optional/` are installed only when selected (see
`skills/optional/README.md` for the full table):

`context-audit`, `project-map`, `run-and-verify`, `dependency-freshness`,
`git-discipline`, `decision-log`, `documentation-update`,
`failure-learning`, `ui-qa`.

Questions:

1. Which optional skill packs should be installed now? (Default: none.)
2. If the repository clearly indicates applicability (e.g. a frontend for
   `ui-qa`, frequent dependency changes for `dependency-freshness`),
   should Claude suggest those packs? (Suggest yes; install only on
   confirmation.)
3. Should declined packs be recorded in `decisions/answers.md` so they are
   not re-proposed every session? (Default: yes.)

## 15. Run and verify generation

Ask only if the `run-and-verify` pack was selected in §14. Inspect the
repository first (`package.json` scripts, `Makefile`, CI config, docs) and
present inferred answers for confirmation; ask only what is missing. Reuse
the §7 answers for test/lint/typecheck/format commands — do not re-ask.
Record anything unknown as `TODO: ask the developer`; never invent a
command.

1. What command starts the local dev server (or runs the project locally),
   and at what URL/port does it respond?
2. What command runs a targeted subset of tests (single file, single test,
   one package)?
3. What command builds the project, if a build step exists?
4. Which services must be running locally (database, queue, containers,
   emulators), and how are they started?
5. Which environment variables are required? Record names only — never
   values. Where are they documented (e.g. an `.env.example` file)?
6. How should UI behavior be verified (routes to open, expected visual
   state, manual checklist, screenshot comparison)?
7. How should API/CLI behavior be verified (example requests, expected
   responses, smoke commands)?

## 16. Dependency and API freshness

Should changes that touch external dependencies, SDKs, APIs, or framework
configuration require explicit verification against current documentation,
with the evidence recorded in the spec or review?

1. Yes for high-risk categories, advisory otherwise (default). High-risk:
   auth, payments, database migrations, cloud infrastructure, framework
   upgrades, security-sensitive code.
2. Yes for all external dependency/API changes.
3. Advisory only: recommend verification but never block on it.

Notes:

- Purely internal changes never require freshness evidence.
- This policy applies even if the `dependency-freshness` pack (§14) is not
  installed: the design template, spec-author rules, and reviewer checklist
  enforce it. The pack adds the step-by-step procedure.
- Record the chosen strictness in `decisions/answers.md`.

## 17. Decision logs and project memory

Durable decisions live in versioned files, not chat history.
`decisions/answers.md` always exists (it records the onboarding answers).
Beyond it, ask:

1. Should architectural decisions be recorded? Where?
   1. `decisions/architecture-decisions.md` (default when the
      `decision-log` pack is selected; created from the kit's template).
   2. `docs/adr/` — if the project already uses ADRs, keep using them in
      the project's existing format and numbering.
   3. Not recorded: decisions live only in specs and `history.html`.
2. Should rejected options/designs be recorded in
   `decisions/rejected-options.md`? (Default: yes when the pack is
   selected — rejected alternatives are what future sessions most often
   re-litigate.)
3. Should workflow decisions ("from now on, X") be recorded in
   `decisions/workflow-decisions.md`? (Default: yes when the pack is
   selected.)

Notes:

- The `decision-log` pack (§14) adds the proposal procedure; without it,
  decisions can still be recorded manually in the same files.
- Only significant decisions are logged — never trivial choices.
- Never log secrets or sensitive operational data.
- Record the chosen locations in `decisions/answers.md`.

## 18. Browser/UI testing with Playwright

```text
Does this project have a browser UI that Claude should be allowed to inspect with Playwright?
1. No browser UI.
2. Yes, add a browser-tester subagent with Playwright MCP scoped to that subagent.
3. Yes, document setup only; do not configure it.
4. Custom.
```

Notes:

- Default: option 1 for projects without a browser UI — nothing related
  to Playwright is installed, and the project is unaffected.
- If the repository clearly has a frontend, suggest option 2 (and the
  `ui-qa` pack from §14, which routes UI verification through the
  agent) — but install only on confirmation.
- Option 2 installs `agents/optional/browser-tester.md` with the
  Playwright MCP declared inline in the agent's frontmatter — the main
  conversation never gets browser tools (see `mcps/playwright-policy.md`).
- Option 3 records the setup reference from `mcps/playwright-policy.md`
  in the project's docs without configuring anything.
- Credentials are never stored anywhere; test accounts preferred;
  explicit approval before any credential is used; no production
  destructive actions.
- Record the choice in `decisions/answers.md`.
