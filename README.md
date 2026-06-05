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
- Do not modify `bugs.md` or `todolist.md` directly — open a PR and let the maintainer triage.
- Template files under `templates/` use `{{PLACEHOLDER}}` syntax; keep that convention.
- Hook scripts must be POSIX-compatible bash and degrade gracefully when `jq` is unavailable.
- Agent files must follow the frontmatter format (`name`, `description`, `tools`).

### Reporting issues

Open a GitHub issue with:
- A short description of the bug or request.
- Steps to reproduce (if a bug).
- The expected vs. actual behavior.

---

## Publishing this repository to GitHub (setup guide for the owner)

Follow these steps to publish this kit publicly while keeping control of who can merge changes.

### 1. Create the public repository

```bash
gh repo create sdd-onboarding-kit --public --description "SDD harness onboarding kit for Claude Code"
```

Or create it on github.com and then:

```bash
git remote add origin https://github.com/<your-username>/sdd-onboarding-kit.git
git branch -M main
git push -u origin main
```

### 2. Push the initial commit

```bash
git add .
git commit -m "Initial public release of SDD onboarding kit"
git push
```

### 3. Protect the main branch

Go to **Settings → Branches → Add rule** (or use the CLI):

```bash
gh api repos/<your-username>/sdd-onboarding-kit/branches/main/protection \
  --method PUT \
  --field required_status_checks=null \
  --field enforce_admins=true \
  --field required_pull_request_reviews='{"required_approving_review_count":1,"dismiss_stale_reviews":true}' \
  --field restrictions=null
```

This requires at least one approving review before any PR can be merged into `main`.

### 4. Restrict who can approve PRs (only you)

Go to **Settings → Branches → Edit rule for `main`** and under "Restrict who can push to matching branches", add only your GitHub username. This means only you can merge or push directly to `main`.

### 5. Set up a CODEOWNERS file

Create `.github/CODEOWNERS`:

```text
* @<your-username>
```

This automatically requests your review on every PR that touches any file.

### 6. Disable force pushes and deletions

In the branch protection rule, check:
- **Do not allow bypassing the above settings** (applies to admins too, for extra safety)
- **Allow force pushes** → OFF
- **Allow deletions** → OFF

### 7. Recommended: add a PR template

Create `.github/pull_request_template.md`:

```markdown
## What does this PR change?

## Why?

## Checklist
- [ ] Files are in English
- [ ] Hook scripts degrade gracefully without jq
- [ ] Templates preserve {{PLACEHOLDER}} syntax
- [ ] No unrelated changes included
```

### 8. Verify the setup

```bash
gh repo view <your-username>/sdd-onboarding-kit --web
```

Check that the `main` branch shows "Protected" under **Settings → Branches**.
