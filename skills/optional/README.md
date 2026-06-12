# Optional skill packs

Source templates for optional, per-project skills. The core SDD behavior
lives in `skills/sdd-workflow/` and is always installed; the packs in this
directory are installed **only when the developer selects them** during
onboarding (see `questions.md` §14) or asks for them later.

## Installation rule

For each selected pack, copy `skills/optional/<name>/` to
`.claude/skills/<name>/` in the target project and adapt placeholders and
project-specific details. Record the selection (installed and declined) in
`decisions/answers.md`.

Do not install unselected packs "just in case", and do not paste skill
bodies into `CLAUDE.md` — list installed skills there by name with a
one-line purpose at most. Skill bodies load only when invoked, which is
what keeps them cheap (see `reference/context-economy.md`).

## Available packs

| Skill | Purpose |
|---|---|
| `context-audit` | Inspect and reduce context-window usage in long sessions. |
| `project-map` | Generate or refresh the project map artifact. |
| `run-and-verify` | Run the project and verify behavior using its real commands. |
| `dependency-freshness` | Check current docs before changing external dependencies/APIs. |
| `git-discipline` | Clean branches, commits, and PR descriptions without risky git actions. |
| `decision-log` | Record durable architectural/workflow decisions. |
| `documentation-update` | Update affected documentation after review, before done. |
| `failure-learning` | Propose a reusable lesson after a meaningful mistake. |
| `ui-qa` | Verify UI changes against spec acceptance criteria. |
| `spec-from-screenshot` | Turn screenshots, mockups, and visual evidence into structured spec material. |

Every pack documents: purpose, when to use, when not to use, required
inputs, output artifact, and safety constraints. All packs are advisory or
permission-gated: none mutates git state, external systems, or memory
without explicit developer approval.
