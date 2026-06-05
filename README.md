# SDD Onboarding Kit for Claude Code

This kit installs a **Spec Driven Development (SDD)** harness in any repository you work on with Claude Code.

It is not a global user configuration. It is a reusable template that produces a project-specific configuration: `CLAUDE.md`, `.claude/agents/`, `.claude/skills/`, `.claude/settings.json`, `specs/`, `tasks.json`, `history.md`, and validation scripts.

## What SDD does

When the harness is installed, Claude Code works like this:

1. The developer selects or describes a task.
2. Claude creates a spec (requirements, design, implementation tasks) before touching any code.
3. The developer reviews and approves the spec.
4. Claude implements only against the approved spec.
5. Claude runs tests and validation.
6. Claude reviews traceability between requirements, design, tasks, code and tests.
7. The task is marked done or returned for correction.

## How to use this kit

Copy or add this folder to the project where you want to install SDD. For example:

```text
my-project/
└── sdd-onboarding-kit/
```

Then open Claude Code in `my-project/` and run:

```text
Read `sdd-onboarding-kit/instructions.md` and configure this repository to use Spec Driven Development. Ask me all necessary questions before making project-specific decisions.
```

Claude Code will inspect the repository, ask you the configuration questions from `questions.md`, and generate a complete project-specific SDD harness.

## Key files

| File | Purpose |
|---|---|
| `instructions.md` | Step-by-step procedure Claude Code follows to install the harness |
| `questions.md` | Project-specific decisions Claude must ask before writing files |
| `agents/` | Subagent templates: leader, spec-author, implementer, reviewer |
| `skills/sdd-workflow/` | Full SDD workflow skill (copied to `.claude/skills/`) |
| `hooks/` | Hook policies, settings snippets and example hook scripts |
| `mcps/` | Criteria for deciding which MCPs to configure |
| `templates/` | File templates Claude adapts to the target project |
| `scripts/` | Base scripts for validating structure, environment and tests |
| `reference/` | SDD theory, harness engineering, Claude Code primitives |
| `output-project-structure.md` | Expected structure of the target project after onboarding |
| `usage-prompts.md` | Ready-to-use prompts for daily SDD use |

## Central principle

The onboarding produces a project-specific configuration. It does not copy generic rules without adapting them. If a decision is missing, Claude Code asks.

## Contributing

Contributions are welcome. To propose a change:

1. Fork the repository.
2. Create a branch from `main` with a descriptive name (e.g. `fix/hook-path-filter` or `feat/linear-mcp-notes`).
3. Make your changes. Keep PRs focused — one concern per PR.
4. Open a pull request against `main` with a clear description of what the change does and why.
5. Wait for review. Only the repository owner merges PRs.

### Guidelines

- Keep all files in English.
- Template files under `templates/` use `{{PLACEHOLDER}}` syntax; keep that convention.
- Hook scripts must be POSIX-compatible bash and degrade gracefully when `jq` is unavailable.
- Agent files must follow the frontmatter format (`name`, `description`, `tools`).

### Reporting issues

Open a GitHub issue with:
- A short description of the bug or request.
- Steps to reproduce (if a bug).
- The expected vs. actual behavior.

---