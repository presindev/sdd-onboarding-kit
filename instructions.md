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
11. `skills/sdd-workflow/SKILL.md`
12. `skills/sdd-workflow/workflow.md`
13. `skills/sdd-workflow/spec-format.md`
14. `skills/sdd-workflow/review-checklist.md`
15. `hooks/hooks-policy.md`
16. `mcps/mcp-policy.md`

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
- existing git branch and cleanliness status.

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
- whether tasks may be skipped as too small for SDD.

If the developer wants a default recommendation, propose the safe default profile in this file.

## Safe default profile

Use this only if the developer explicitly asks for recommended defaults.

```yaml
sdd_scope: tasks_marked_sdd_true
human_approval_required: true
requirements_format: EARS
task_storage: local_tasks_json
spec_storage: specs/<feature-slug>/
history_storage: history.html
mcp_profile: none_by_default
hooks_profile: recommend_but_do_not_enable_without_approval
git_branch_policy: ask_before_creating_branch
git_commit_policy: ask_before_committing
tests_required_before_done: true
reviewer_required_before_done: true
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
│   │   └── reviewer.md
│   ├── skills/
│   │   └── sdd-workflow/
│   │       ├── SKILL.md
│   │       ├── workflow.md
│   │       ├── spec-format.md
│   │       ├── task-state-machine.md
│   │       ├── review-checklist.md
│   │       ├── intake-from-functional-doc.md
│   │       ├── assumptions-policy.md
│   │       ├── open-questions-policy.md
│   │       ├── examples.md
│   │       └── templates/
│   │           ├── requirements.html.template
│   │           ├── design.html.template
│   │           ├── tasks.html.template
│   │           ├── review.html.template
│   │           ├── acceptance-tests.html.template
│   │           ├── assumptions.html.template
│   │           ├── open-questions.html.template
│   │           ├── spec.css
│   │           └── spec.js
│   ├── hooks/
│   │   └── README.md
│   └── settings.json
├── specs/
├── decisions/
│   └── answers.md
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

### Subagents

Copy and adapt:

- `agents/leader.md` to `.claude/agents/leader.md`
- `agents/spec-author.md` to `.claude/agents/spec-author.md`
- `agents/implementer.md` to `.claude/agents/implementer.md`
- `agents/reviewer.md` to `.claude/agents/reviewer.md`

If the project already has agents with these names, merge carefully or ask before overwriting.

### Skill

Copy and adapt the full `skills/sdd-workflow/` directory into:

```text
.claude/skills/sdd-workflow/
```

This skill contains the full multi-step SDD procedure. Keep `CLAUDE.md` short and use the skill for operational detail.

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

### Onboarding decisions record

Create `decisions/answers.md` in the target project from `decisions/answers.template.md`, filled with the developer's answers to the onboarding questions. Workflow-level assumptions and onboarding decisions are recorded there.

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
4. Verify all generated files have no unresolved placeholders (Markdown and HTML).
5. Verify the project `CLAUDE.md` points to `.claude/skills/sdd-workflow/SKILL.md`.
6. Verify that task statuses in `tasks.json` match the configured state machine.

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