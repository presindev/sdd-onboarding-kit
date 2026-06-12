# SDD onboarding instructions for Claude Code

You are configuring the current target repository to use **Spec Driven Development (SDD)** with Claude Code.

Your job is to install a project-specific SDD harness. Do not implement product features during onboarding unless the developer explicitly asks for a separate implementation task after the harness is installed.

## Mandatory read order

Read these files in this order before writing project files:

1. `reference/sdd-theory.md`
2. `reference/harness-engineering.md`
3. `reference/claude-code-primitives.md`
4. `questions.md`
5. `output-project-structure.md`
6. `templates/CLAUDE.md.template`
7. `agents/leader.md`
8. `agents/spec-author.md`
9. `agents/implementer.md`
10. `agents/reviewer.md`
11. `agents/documenter.md`
12. `skills/sdd-workflow/SKILL.md`
13. `skills/sdd-workflow/workflow.md`
14. `skills/sdd-workflow/spec-format.md`
15. `skills/sdd-workflow/review-checklist.md`
16. `hooks/hooks-policy.md`
17. `mcps/mcp-policy.md`

If any of these files are missing, stop and tell the developer which file is missing.

## Phase 1 — Inspect the target repository

Inspect the current repository before asking configuration questions.

Identify:

- language or languages;
- framework;
- package manager;
- test framework;
- lint/typecheck/format commands;
- existing `README`, `docs`, `Makefile`, `package.json`, `pyproject.toml`, `Cargo.toml`, `go.mod`, `pom.xml`, `build.gradle`, or equivalent;
- existing `CLAUDE.md`, `.claude/`, `.mcp.json`, task files, issue references, CI config;
- existing architecture/conventions documentation;
- existing git branch and cleanliness status;
- available external CLIs (`gh`, `vercel`, `supabase`, cloud CLIs): detect which exist so narrow CLI calls can be preferred over broad MCP loading (`reference/cli-vs-mcp-policy.md`) — do not require, install, or authenticate any of them, and record nothing about credentials beyond authenticated yes/no.

Do not overwrite existing files without first reading them.

## Phase 2 — Ask unresolved decisions

Use `questions.md` as the source of questions.

Ask only questions that cannot be inferred confidently from the repository. Group them so the developer can answer quickly.

You must not assume:

- whether every task uses SDD;
- whether human approval is mandatory;
- what requirements format to use;
- what task storage backend to use;
- what MCPs to configure;
- what hooks to enable;
- what commands run tests, lint, typecheck or formatting;
- whether to create branches, commits or pull requests;
- whether tasks may be skipped as too small for SDD;
- which optional skill packs to install;
- how strictly dependency/API freshness verification should be enforced;
- whether autonomous workflows are allowed beyond read-only monitoring;
- whether deep review is required (vs recommended) for any category;
- whether the documentation phase may be relaxed.

If the developer wants a default recommendation, propose the safe default profile in this file (offered as a single question first — see the `Recommended defaults profile` block at the top of `questions.md`; if accepted, ask only the §7 commands, §11 protected files, §1 SDD scope, and flagged deviations).

## Safe default profile

Use this only if the developer explicitly asks for recommended defaults.

```yaml
sdd_scope: tasks_marked_sdd_true
human_approval_required: true
requirements_format: EARS
task_storage: local_tasks_json
spec_storage: specs/<feature-slug>/
history_storage: history.html
local_first: true                  # no external MCPs or CLIs required
mcp_profile: none_by_default       # external MCPs only on explicit opt-in
hooks_profile: recommend_but_do_not_enable_without_approval
git_branch_policy: ask_before_creating_branch
git_commit_policy: ask_before_committing
git_mutations: explicit_permission_per_action
tests_required_before_done: true
reviewer_required_before_done: true
documentation_phase: enabled       # not done while required docs pending
dependency_freshness_policy: required_for_high_risk_categories
failure_learning: proposals_enabled_no_automatic_writes
memory_scope: project_default_global_only_with_explicit_approval
browser_testing: disabled_unless_frontend_detected_and_opted_in
autonomy: disabled_except_documented_readonly_monitoring
deep_review: recommended_for_high_risk_paid_modes_per_invocation_approval
session_recovery_rule: enabled_in_claude_md
```

## Phase 3 — Generate the project SDD harness

After the developer answers, create or update the following in the target repository:

```text
<project>/
├── CLAUDE.md
├── .claude/
│   ├── agents/
│   │   ├── leader.md
│   │   ├── spec-author.md
│   │   ├── implementer.md
│   │   ├── reviewer.md
│   │   ├── documenter.md
│   │   └── <browser-tester.md, if questions.md §18 selected it>
│   ├── skills/
│   │   ├── sdd-workflow/
│   │   │   ├── SKILL.md
│   │   │   ├── workflow.md
│   │   │   ├── spec-format.md
│   │   │   ├── task-state-machine.md
│   │   │   ├── review-checklist.md
│   │   │   ├── intake-from-functional-doc.md
│   │   │   ├── assumptions-policy.md
│   │   │   ├── open-questions-policy.md
│   │   │   ├── examples.md
│   │   │   └── templates/
│   │   │       ├── requirements.html.template
│   │   │       ├── design.html.template
│   │   │       ├── tasks.html.template
│   │   │       ├── review.html.template
│   │   │       ├── acceptance-tests.html.template
│   │   │       ├── assumptions.html.template
│   │   │       ├── open-questions.html.template
│   │   │       ├── spec.css
│   │   │       └── spec.js
│   │   └── <optional skill packs selected during onboarding>/
│   ├── context/
│   │   └── project-map.md
│   ├── hooks/
│   │   └── README.md
│   └── settings.json
├── specs/
├── decisions/
│   ├── answers.md
│   └── <decision-log files, if the decision-log pack is selected>
├── tasks.json
├── history.html
└── scripts/
    ├── init.sh
    ├── run-tests.sh
    ├── run-lint.sh
    └── validate-sdd-structure.sh
```

Adapt every file to the target project. Do not leave unresolved placeholders such as `{{TEST_COMMAND}}` in final project files unless the developer explicitly says that the command is unknown and should remain as a TODO.

## Phase 4 — File generation rules

### `CLAUDE.md`

Create the project `CLAUDE.md` from `templates/CLAUDE.md.template`.

It must be concise and project-specific. It should contain:

- project summary;
- build/test/lint commands;
- SDD workflow policy;
- status transitions;
- human approval policy;
- where specs, tasks and history live;
- how to invoke the SDD skill;
- when not to use SDD;
- protected files or risky areas.

Do not put the full theory of SDD into `CLAUDE.md`. Put long procedures in the project skill.

Do not embed a directory tree in `CLAUDE.md`; link the project map instead (replace `{{PROJECT_MAP_PATH}}` with the configured location).

### Project map

Generate a project map from `templates/project-map.md.template`, filled with the Phase 1 inspection results.

- Default location: `.claude/context/project-map.md`. Use `docs/project-map.md` if the developer prefers it visible in docs (see `questions.md` §12).
- Keep it concise: shallow annotated tree (2–3 levels), no exhaustive file listing, no generated/vendored directories.
- Record unknown commands as `TODO: ask the developer` — do not invent them.
- Never record secrets, credentials, or tokens.
- If the developer defers generation, record a clear TODO (in `decisions/answers.md` and the onboarding summary) instead of creating an empty file.
- The map carries its own maintenance rule: it must be updated when the repository structure changes significantly.

### Subagents

Copy and adapt:

- `agents/leader.md` to `.claude/agents/leader.md`
- `agents/spec-author.md` to `.claude/agents/spec-author.md`
- `agents/implementer.md` to `.claude/agents/implementer.md`
- `agents/reviewer.md` to `.claude/agents/reviewer.md`
- `agents/documenter.md` to `.claude/agents/documenter.md`

If the project already has agents with these names, merge carefully or ask before overwriting.

### Optional browser tester

Only if the developer chose option 2 in `questions.md` §18, copy and adapt `agents/optional/browser-tester.md` to `.claude/agents/browser-tester.md`. The Playwright MCP stays declared inline in the agent's frontmatter — do not add it to `.mcp.json` (see `mcps/playwright-policy.md`). Verify the frontmatter `mcpServers` syntax and the Playwright launch command against the installed Claude Code version before finalizing the file. For option 3, record the setup reference in the project's docs without configuring anything.

### Skill

Copy and adapt the full `skills/sdd-workflow/` directory into:

```text
.claude/skills/sdd-workflow/
```

This skill contains the full multi-step SDD procedure. Keep `CLAUDE.md` short and use the skill for operational detail.

### Optional skill packs

The core `sdd-workflow` skill is always installed. The packs under `skills/optional/` are installed only when the developer selects them (see `questions.md` §14).

- For each selected pack, copy `skills/optional/<name>/` to `.claude/skills/<name>/` and adapt placeholders and project-specific details (commands, paths, doc locations). Exception: `run-and-verify` is generated from a template, not copied — see "Run and verify skill" below.
- If `failure-learning` is selected, also copy `templates/memory/failure-learning-entry.md` to `.claude/skills/failure-learning/entry-template.md` (the skill references it), keeping its placeholder tokens — entries are instantiated per lesson, not during onboarding. Memory scope rules come from `reference/memory-policy.md`: project memory by default, never a global write without explicit approval.
- If `git-discipline` is selected, also copy `templates/git/` (commit-message, PR-description, and release-note templates) to `.claude/skills/git-discipline/templates/`, adapt them to the `questions.md` §8 git-policy answers (commit convention, task-reference format, changelog categories), and delete the generator-notes comments from the adapted copies.
- If `decision-log` is selected, also create the decision files the developer chose in `questions.md` §17 from the kit's templates: `decisions/architecture-decisions.template.md`, `decisions/rejected-options.template.md`, `decisions/workflow-decisions.template.md` → `decisions/<name>.md`. If the project already uses `docs/adr/`, architecture decisions stay there in the project's existing format — do not create a competing file. Record the chosen locations in `decisions/answers.md` and adapt the installed skill to them.
- If the repository clearly indicates applicability (e.g. a frontend for `ui-qa` and `spec-from-screenshot`), suggest the pack — but install only on confirmation.
- Record installed and declined packs in `decisions/answers.md`.
- In `CLAUDE.md`, list installed optional skills by name with a one-line purpose at most. Never paste skill bodies into `CLAUDE.md`: skill content loads only when invoked, which is what keeps it cheap.

### Run and verify skill

If the developer selected the `run-and-verify` pack (`questions.md` §14), generate `.claude/skills/run-and-verify/SKILL.md` from `templates/run-and-verify.md.template` instead of copying the pack file verbatim.

- Fill the placeholders from the Phase 1 inspection first (`package.json` scripts, `Makefile`, CI config, existing docs), confirm inferred commands with the developer, and ask the `questions.md` §15 questions only for what remains unknown.
- Reuse the §7 answers for test/lint/typecheck commands — do not re-ask.
- Record any command that cannot be confirmed as `TODO: ask the developer`. Never invent a command.
- Record required environment variables by name only. Never write secret values, tokens, or credentials into the generated skill or any other file.
- The generated skill is the project's run/verify recipe: implementer and reviewer run applicable checks through it (see `agents/implementer.md`, `agents/reviewer.md`, and the review checklist).

### Spec templates

Copy the HTML spec templates and shared assets into the target project so the spec-author has a source when creating new feature specs after the kit is removed:

```text
templates/specs/requirements.html.template      → .claude/skills/sdd-workflow/templates/requirements.html.template
templates/specs/design.html.template            → .claude/skills/sdd-workflow/templates/design.html.template
templates/specs/tasks.html.template             → .claude/skills/sdd-workflow/templates/tasks.html.template
templates/specs/review.html.template            → .claude/skills/sdd-workflow/templates/review.html.template
templates/specs/acceptance-tests.html.template  → .claude/skills/sdd-workflow/templates/acceptance-tests.html.template
templates/specs/assumptions.html.template       → .claude/skills/sdd-workflow/templates/assumptions.html.template
templates/specs/open-questions.html.template    → .claude/skills/sdd-workflow/templates/open-questions.html.template
templates/specs/spec.css                        → .claude/skills/sdd-workflow/templates/spec.css
templates/specs/spec.js                         → .claude/skills/sdd-workflow/templates/spec.js
```

Copy these verbatim, including the `{{PLACEHOLDER}}` tokens. They are instantiated per feature, not during onboarding.

Do NOT copy the kit's `specs/example-feature/` directory into the target project. It is a rendered reference example for humans and agents, not part of the installed harness.

### Onboarding decisions record

Create `decisions/answers.md` in the target project from `decisions/answers.template.md`, filled with the developer's answers to the onboarding questions. Workflow-level assumptions and onboarding decisions are recorded there.

If the `decision-log` pack was selected, the additional decision files are created alongside it — see "Optional skill packs" above.

### Hooks

Do not enable hooks silently.

Hook scripts and the scripts under `scripts/` are bash and most rely on `jq`. On Windows they require Git Bash (or WSL) plus `jq` on `PATH`; the example hooks fail open (warn and allow) when `jq` is missing. Confirm with the developer that the team's environment provides bash and `jq` before enabling any hook (see `questions.md` §9).

If the developer approves hooks, create `.claude/settings.json` entries from `hooks/settings-snippets.md` and copy any required hook scripts into `scripts/` or `.claude/hooks/`.

Prefer hooks for deterministic constraints such as:

- blocking implementation before spec approval;
- running validation after edits;
- preventing dangerous shell commands;
- validating task state transitions.

### MCPs

Do not configure MCPs silently.

If the developer chooses MCPs, use `mcps/mcp-policy.md` and the relevant integration notes.

If no MCPs are selected, use local HTML/JSON storage:

- `tasks.json`
- `specs/<feature>/`
- `history.html`

## Phase 5 — Validate installation

After writing files:

1. Run `scripts/validate-sdd-structure.sh` if safe.
2. Run `scripts/init.sh` if safe.
3. Run the configured test command if the developer approved running tests.
4. Verify all generated files have no unresolved placeholders (Markdown and HTML). Exception: the spec templates under `.claude/skills/sdd-workflow/templates/` keep their `{{PLACEHOLDER}}` tokens by design.
5. Verify the project `CLAUDE.md` points to `.claude/skills/sdd-workflow/SKILL.md`.
6. Verify that task statuses in `tasks.json` match the configured state machine.
7. Verify the project map exists at the configured location and is linked from `CLAUDE.md`, or that a TODO records that generation was deferred.
8. If the `run-and-verify` pack was selected, verify `.claude/skills/run-and-verify/SKILL.md` has no unresolved placeholders (unknown commands appear as explicit `TODO: ask the developer` entries), no invented commands, and no secret values — environment variables by name only.

## Phase 6 — Final onboarding summary

At the end, report:

- files created;
- files modified;
- hooks enabled or left disabled;
- MCPs configured or left unconfigured;
- project-specific commands detected;
- open TODOs;
- the first command/prompt the developer should use to start an SDD task.

## Explicit non-goals

During onboarding, do not:

- implement a product feature;
- refactor the codebase;
- invent missing business requirements;
- enable external integrations without approval;
- run destructive commands;
- commit changes unless the developer explicitly asked for commits.

## Functional document intake

If the developer provides a functional document, treat it as source material, not as an approved spec.

Convert it into an SDD spec before implementation.

Never implement directly from a functional document unless the developer explicitly disables SDD for that task.

If the developer provides a functional document, product brief, ticket, PRD, user story, or informal feature description, read:

1. `skills/sdd-workflow/intake-from-functional-doc.md`
2. `skills/sdd-workflow/assumptions-policy.md`
3. `skills/sdd-workflow/open-questions-policy.md`
4. `templates/functional/functional-brief.html.template`
5. `templates/specs/assumptions.html.template`
6. `templates/specs/open-questions.html.template`
7. `templates/specs/acceptance-tests.html.template`

Claude Code must treat the functional document as source material, not as an approved implementation spec.

Claude Code must generate or update the SDD spec before implementation.