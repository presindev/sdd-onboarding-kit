# SDD Onboarding Kit — Documentation

## Table of contents

1. [What is SDD](#1-what-is-sdd)
2. [What this kit is](#2-what-this-kit-is)
3. [Installation](#3-installation)
4. [Daily workflow](#4-daily-workflow)
5. [Task lifecycle](#5-task-lifecycle)
6. [Spec format](#6-spec-format)
7. [Subagents](#7-subagents)
8. [Hooks](#8-hooks)
9. [MCP integrations](#9-mcp-integrations)
10. [Configuration reference](#10-configuration-reference)
11. [Kit file reference](#11-kit-file-reference)
12. [Ready-to-use prompts](#12-ready-to-use-prompts)

---

## 1. What is SDD

**Spec Driven Development (SDD)** is a workflow where Claude Code writes and gets approval for a specification before touching any production code. The spec covers:

- **Requirements** — observable behavior the feature must satisfy.
- **Design** — which files to change, how, and why.
- **Tasks** — an ordered, checkable implementation checklist.

The developer reviews the spec and explicitly approves it. Claude then implements strictly against the approved spec. An automated reviewer validates that the result matches the spec, requirements are traceable, and tests pass.

The goal is to eliminate ambiguity, prevent scope creep, and give the developer a meaningful decision point before code is written.

---

## 2. What this kit is

This kit is a **reusable installer**. It produces a project-specific SDD harness, not a global configuration.

When you run the onboarding prompt, Claude Code reads the kit, inspects your repository, asks you project-specific questions, and generates:

- A `CLAUDE.md` tailored to your project.
- Four Claude subagents (leader, spec-author, implementer, reviewer).
- The full SDD workflow skill.
- Local task and spec storage.
- Optional hooks and MCP integrations.
- Validation scripts.

The kit itself stays inert. Only the generated harness in your project becomes active.

---

## 3. Installation

### Prerequisites

- Claude Code (CLI, desktop app, or IDE extension).
- A git repository where you want SDD installed.

### Steps

**Step 1 — Add the kit to your project**

Copy or clone this kit folder into your project root:

```text
my-project/
└── sdd-onboarding-kit/
```

You can also add it as a git submodule or keep it alongside the project in a shared location.

**Step 2 — Open Claude Code in your project**

Open Claude Code with `my-project/` as the working directory.

**Step 3 — Run the onboarding prompt**

Paste this prompt into Claude Code:

```text
Read `sdd-onboarding-kit/instructions.md` and configure this repository to use Spec Driven Development. Ask me all necessary questions before making project-specific decisions.
```

**Step 4 — Answer the configuration questions**

Claude Code will inspect your repository and ask you about:

- Scope: does SDD apply to every task or only those marked `sdd: true`?
- Human approval: is approval mandatory before implementation starts?
- Requirements format: EARS, user stories, Given/When/Then, or numbered.
- Task storage: local `tasks.json`, GitHub Issues, Linear, Jira, or other.
- State machine: which statuses to use, who can approve specs.
- Tests: commands to run tests, lint, and typecheck.
- Git policy: branching, commit strategy, pull requests.
- Hooks: which enforcement rules to enable.
- MCPs: which external systems Claude should access.
- Protected files: what Claude must not modify without explicit approval.

You only need to answer questions that your repository does not already answer. Claude infers what it can.

**Step 5 — Review and confirm**

Claude generates a summary of files created, hooks enabled, and any open TODOs. Review the generated `CLAUDE.md` and the contents of `.claude/` before starting work.

### What gets created

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
│   │       └── examples.md
│   ├── hooks/
│   │   └── README.md
│   └── settings.json
├── specs/
├── tasks.json
├── history.md
└── scripts/
    ├── init.sh
    ├── run-tests.sh
    ├── run-lint.sh
    └── validate-sdd-structure.sh
```

If you selected external task management or documentation MCPs, the harness may also create `.mcp.json`, `docs/adr/`, `docs/architecture.md`, and `docs/conventions.md`.

---

## 4. Daily workflow

Once the harness is installed, your interaction with Claude Code changes to follow these patterns.

### Start a new feature

```text
Create a new SDD task for: <description>. First generate requirements/design/tasks and do not implement anything until I approve the spec.
```

Claude will:
1. Create a task entry in `tasks.json`.
2. Create `specs/<feature-slug>/requirements.md`, `design.md`, and `tasks.md`.
3. Stop and present the spec for your review.

### Review and approve a spec

Read the generated spec files under `specs/<feature-slug>/`. When you are satisfied:

```text
I have reviewed the spec for `<feature-slug>` and I approve it. Change the status to `human_approved` and prepare the implementation following `tasks.md`.
```

Claude will not write code until it receives this approval.

### Implement an approved spec

```text
Implement feature `<feature-slug>` following the approved spec strictly. Run tests and leave traceability of what you changed.
```

Claude implements in the order specified by `tasks.md`, runs validation, and moves the task to `review`.

### Review an implementation

```text
Use the reviewer to validate the implementation of `<feature-slug>` against requirements.md, design.md and tasks.md. Run tests and tell me if it can be marked as done.
```

The reviewer checks requirement coverage, test coverage, design adherence, and convention compliance, then writes `specs/<feature-slug>/review.md`.

### Resume the next pending task

```text
Use the SDD workflow. Review `tasks.json`, select the next pending task marked with `sdd: true`, generate the spec and stop for human approval.
```

### Work from a functional document or PRD

If you have a product brief, ticket, or informal description, paste it and ask Claude to convert it:

```text
Here is the functional document for <feature>. Convert it into an SDD spec. Do not implement anything until I approve.
```

Claude reads the document, identifies assumptions and open questions, produces the spec, and stops for your approval.

### Tasks that do not need SDD

For small fixes, documentation edits, or any task you have configured to bypass SDD, you can work normally. The harness only enforces SDD for tasks configured to require it (e.g., tasks with `sdd: true` in `tasks.json`).

---

## 5. Task lifecycle

Every SDD task moves through a defined state machine. The default states are:

```text
pending → spec_draft → spec_ready → human_approved → in_progress → review → done
```

Optional states: `blocked`, `rejected`.

| State | Meaning | Who can advance it |
|---|---|---|
| `pending` | Task exists, no spec yet | Claude (starts drafting) |
| `spec_draft` | Spec is being written or revised | Claude |
| `spec_ready` | Spec is complete, awaiting approval | Claude (sets after finishing spec) |
| `human_approved` | Developer approved the spec | Developer only |
| `in_progress` | Implementation underway | Claude |
| `review` | Implementation complete, under validation | Claude |
| `done` | Complete | Reviewer (after passing tests and checklist) |
| `blocked` | Waiting on external input | Either party |
| `rejected` | Review found blocking defects | Reviewer |

**Key rules:**

- Claude never moves a task from `spec_ready` to `in_progress` directly when human approval is required.
- Claude never marks a task `done` with failing tests unless you explicitly accept the exception.
- A task can return to `spec_draft` from any forward state if the spec turns out to be wrong.
- Completed tasks are archived to `history.md`.

---

## 6. Spec format

Each feature gets a directory under `specs/`:

```text
specs/<feature-slug>/
├── requirements.md
├── design.md
├── tasks.md
├── assumptions.md       (when derived from a functional document)
├── open-questions.md    (when derived from a functional document)
├── acceptance-tests.md  (when derived from a functional document)
└── review.md            (written by the reviewer)
```

### `requirements.md`

Defines observable behavior. Supported requirement formats:

- **EARS**: `When <trigger>, the system shall <response>.` — best for test mapping.
- **User stories**: `As a <role>, I want <capability>, so that <benefit>.` with acceptance criteria.
- **Given/When/Then**: scenario-driven behavior.
- **Numbered requirements**: plain list for simple cases.

Contains: summary, functional requirements, non-functional requirements, edge cases, error states, acceptance criteria, and a requirement-to-test mapping table.

### `design.md`

Translates requirements into a technical plan. Contains: technical summary, files to change, files not to change, interfaces and contracts, data model changes, test design, risks and trade-offs, and a rollback plan.

### `tasks.md`

An ordered, checkable implementation checklist. Each task references one or more requirements. Test and validation tasks are included.

Example:

```md
- [ ] T1: Add tests for `REQ-001` and `REQ-002`.
- [ ] T2: Implement `--limit` flag parsing.
- [ ] T3: Add limit validation and error message.
- [ ] T4: Run `scripts/run-tests.sh`.
```

### `review.md`

Written by the reviewer after implementation. Contains a traceability table, commands run, findings, a pass/fail decision, and follow-up items.

---

## 7. Subagents

The harness installs four Claude subagents under `.claude/agents/`. Each has a distinct role and a defined set of allowed tools.

### Leader (`leader.md`)

The orchestrator. It reads task state and routes work to the correct specialist. It never writes production code itself.

- Reads `tasks.json` and `specs/<feature>/`.
- Decides which phase runs based on task status.
- Invokes spec-author, implementer, or reviewer as appropriate.
- Stops for human approval when the project requires it.
- Records progress in `history.md` after completion.

### Spec Author (`spec-author.md`)

Writes and revises specs. It reads requirements, understands the codebase, and produces `requirements.md`, `design.md`, and `tasks.md`. When working from a functional document it also produces `assumptions.md`, `open-questions.md`, and `acceptance-tests.md`.

### Implementer (`implementer.md`)

The only agent allowed to write production code. It reads the approved spec strictly, implements in task order, adds or updates tests, runs validation, and marks tasks complete. It does not deviate from the spec without asking first.

### Reviewer (`reviewer.md`)

Validates that the implementation satisfies the spec. It checks requirement coverage, test coverage, design adherence, and convention compliance. It writes `review.md` and decides: approved (→ `done`), corrections required (→ `in_progress`), or spec revision required (→ `spec_draft`).

---

## 8. Hooks

Hooks are optional shell scripts that Claude Code executes automatically at defined points in the workflow. They let you enforce rules that prompts alone cannot guarantee.

**Hooks are never enabled without your explicit approval.**

### Available hooks

| Hook | Event | Purpose |
|---|---|---|
| Block implementation before approval | `PreToolUse` on Edit/Write | Prevents code edits when the task is still `pending`, `spec_draft`, or `spec_ready` |
| Run tests after edits | `PostToolUse` on Edit/Write | Automatically runs the test suite after any source edit |
| Validate spec before status change | `PreToolUse` | Ensures `requirements.md`, `design.md`, and `tasks.md` all exist before moving to `spec_ready` |
| Block destructive commands | `PreToolUse` on Bash | Intercepts `rm -rf`, `git reset --hard`, `drop database`, and similar commands |
| Notify for human approval | `Stop` / `Notification` | Alerts you when Claude stops waiting for spec approval |

### Hook modes

- **Advisory**: prints a warning but does not block. Good for early adoption.
- **Blocking**: exits non-zero or returns a block decision. Use for mature, well-tested rules.
- **Async**: runs in the background. Use for slow validations or external notifications.

### Enabling hooks

During onboarding, Claude will ask which hooks to enable. Approved hooks are written to `.claude/settings.json`. The recommended rollout is:

1. Start with no hooks enabled.
2. Install hook scripts as examples only.
3. Enable warning-only mode first.
4. Move to blocking mode after the team trusts the workflow.

---

## 9. MCP integrations

MCPs (Model Context Protocol servers) let Claude Code connect directly to external systems. The harness works fully without any MCPs using local files only.

**MCPs are never configured without your explicit approval.**

### Available integrations

| MCP | Use case |
|---|---|
| GitHub | Read/write issues, pull requests, repository metadata |
| Linear | Project and task management |
| Jira | Enterprise task management |
| Notion / Confluence / Google Drive | Documentation and knowledge bases |
| Memory | Persistent architecture decisions and conventions |
| Database explorer | Schema inspection |
| Observability | Monitoring dashboards and alerts |

### Default (no MCP)

Without MCPs, all state lives locally:

- `tasks.json` — task list and status.
- `specs/<feature-slug>/` — all spec files.
- `history.md` — completed task archive.

### Security

External MCP content is treated as data, not authority. Claude summarizes proposed writes to external systems before executing them and never updates tickets or PRs without your confirmation.

---

## 10. Configuration reference

The generated `CLAUDE.md` is the central configuration file for your project's SDD harness. It encodes all decisions made during onboarding. Key sections:

| Section | What it controls |
|---|---|
| Build/test/lint commands | What Claude runs for validation |
| SDD workflow policy | Which tasks require SDD |
| Human approval policy | Whether approval is mandatory and who grants it |
| State machine | Allowed statuses and transitions |
| Spec and task storage | Where specs and tasks live |
| Skill invocation | How to call the SDD skill |
| Non-SDD tasks | What is explicitly exempt from SDD |
| Protected files | Files Claude must not modify without approval |

Long procedures live in `.claude/skills/sdd-workflow/` rather than in `CLAUDE.md`.

### `tasks.json` schema (local storage)

```json
{
  "tasks": [
    {
      "id": "TASK-001",
      "slug": "feature-slug",
      "title": "Short title",
      "description": "What the feature does",
      "sdd": true,
      "status": "pending",
      "spec": "specs/feature-slug/",
      "approval": null
    }
  ]
}
```

### `history.md` entry format

```md
## YYYY-MM-DD — TASK-001 — feature-slug

- Status: done
- Spec: `specs/feature-slug/`
- Summary: ...
- Files changed: ...
- Tests run: ...
- Reviewer decision: approved
- Follow-ups: ...
```

---

## 11. Kit file reference

| Path | Purpose |
|---|---|
| `instructions.md` | Step-by-step procedure Claude follows to install the harness |
| `questions.md` | All project-specific decisions Claude must ask before writing files |
| `output-project-structure.md` | Expected structure of the target project after onboarding |
| `usage-prompts.md` | Ready-to-use prompts for daily SDD work |
| `manifest.md` | Complete list of all files in the kit |
| `agents/leader.md` | Leader subagent template |
| `agents/spec-author.md` | Spec-author subagent template |
| `agents/implementer.md` | Implementer subagent template |
| `agents/reviewer.md` | Reviewer subagent template |
| `skills/sdd-workflow/` | Full SDD workflow skill (copied to target project) |
| `hooks/hooks-policy.md` | Policy for enabling hooks |
| `hooks/recommended-hooks.md` | Descriptions of available hooks |
| `hooks/settings-snippets.md` | Ready-to-paste `settings.json` entries for each hook |
| `mcps/mcp-policy.md` | Policy for MCP selection and security |
| `mcps/github.md` | GitHub MCP integration notes |
| `mcps/linear.md` | Linear MCP integration notes |
| `mcps/jira.md` | Jira MCP integration notes |
| `mcps/memory.md` | Memory MCP integration notes |
| `templates/CLAUDE.md.template` | Template for the project `CLAUDE.md` |
| `templates/tasks.json.template` | Template for `tasks.json` |
| `templates/history.md.template` | Template for `history.md` |
| `templates/specs/` | Templates for each spec file |
| `scripts/init.sh` | Initialization script run after onboarding |
| `scripts/validate-sdd-structure.sh` | Validates that all required harness files are present |
| `reference/sdd-theory.md` | Full SDD theory and rationale |
| `reference/harness-engineering.md` | Harness engineering principles |
| `reference/claude-code-primitives.md` | Claude Code primitives used by the harness |
| `decisions/answers.template.md` | Template for recording onboarding decisions |

---

## 12. Ready-to-use prompts

### Install the harness

```text
Read `sdd-onboarding-kit/instructions.md` and configure this repository to use Spec Driven Development. Ask me all necessary questions before making project-specific decisions.
```

### Start the next pending task

```text
Use the SDD workflow. Review `tasks.json`, select the next pending task marked with `sdd: true`, generate the spec and stop for human approval.
```

### Create a new task

```text
Create a new SDD task for: <description>. First generate requirements/design/tasks and do not implement anything until I approve the spec.
```

### Approve a spec

```text
I have reviewed the spec for `<feature-slug>` and I approve it. Change the status to `human_approved` and prepare the implementation following `tasks.md`.
```

### Implement an approved spec

```text
Implement feature `<feature-slug>` following the approved spec strictly. Run tests and leave traceability of what you changed.
```

### Review an implementation

```text
Use the reviewer to validate the implementation of `<feature-slug>` against requirements.md, design.md and tasks.md. Run tests and tell me if it can be marked as done.
```

### Convert a functional document to a spec

```text
Here is the functional document for <feature>. Convert it into an SDD spec. Do not implement anything until I approve.
```

### Check harness structure

```text
Run `scripts/validate-sdd-structure.sh` and report any missing files or unresolved placeholders.
```
