# Kit-internal spec — PR 2: Context economy policy

> **Scope note:** kit-internal SDD spec for the `sdd-onboarding-kit`
> repository itself. Not part of the installed harness; never copied during
> onboarding (same rule as `specs/example-feature/`).

## Meta

| Field | Value |
|---|---|
| Task | PR 2 from `todolist.md` (local roadmap) |
| Status | `done` |
| Approval | Per the agreed workflow (2026-06-10): the developer merges each roadmap GitHub PR before the next is implemented; merging roadmap PR 1 (GitHub #5) with this spec already drafted authorized PR 2 implementation. |

## Requirements

R1. The kit SHALL have `reference/context-economy.md` documenting the
principle that Claude Code's context window is a scarce resource and the
practices that protect it.

R2. `reference/context-economy.md` SHALL document when Claude should use or
recommend:
- `/context` to inspect context usage;
- `/compact` between unrelated tasks;
- selective compacting with instructions to preserve decisions, task status,
  architecture constraints, and unresolved questions;
- subagents for noisy research/exploration;
- skills for repeatable long procedures;
- linked documentation instead of copying content into `CLAUDE.md`.

R3. `templates/CLAUDE.md.template` SHALL gain a concise `Context economy`
section (a few lines linking to deeper guidance, not the full policy —
consistent with the policy itself).

R4. The policy SHALL state that `CLAUDE.md` must remain concise and link to
deeper files instead of duplicating them.

R5. The policy SHALL recommend avoiding MCP-heavy toolsets unless needed
(cross-referencing `mcps/mcp-policy.md`).

R6. `README.md` (and its mirror `README.html`) SHALL include a short note
that the kit is designed to protect Claude Code's context window.

R7. `DOCUMENTATION.html` SHALL gain a full `Context economy` section with:
- examples of good vs bad context loading;
- guidance on `CLAUDE.md` length and linked documentation;
- guidance on when to compact, when to spawn subagents, when to use skills.

R8. Command names (`/context`, `/compact`) SHALL be verified against the
current Claude Code environment before being documented (todolist
non-negotiable: verify commands before documenting them).

## Design

Files changed:

| File | Change |
|---|---|
| `reference/context-economy.md` | New file: full context-economy policy (R1, R2, R4, R5). |
| `templates/CLAUDE.md.template` | Add short `Context economy` section near the end, before `Final rule` (R3). |
| `README.md` + `README.html` | One short note in the `Documentation`/intro area (R6). |
| `DOCUMENTATION.html` | New section `15. Context economy` in the `Documentation` TOC group (R7). |
| `DOCUMENTATION.html` §13 table | Add `reference/context-economy.md` to the theory/policy row links. |
| `todolist.md` | Check PR 2 boxes. |
| `manifest.md` | Regenerate after adding the new reference file and this spec. |

Decisions:

- The template section stays under ~10 lines: the durable rule ("keep this
  file short, link out, compact between unrelated tasks, use subagents for
  noisy exploration") plus a pointer; the full policy lives in the new
  reference file, which onboarding may optionally copy or link.
- `/context` and `/compact` are built-in Claude Code slash commands; verify
  in the installed environment (`claude --help` / slash-command list) before
  finalizing wording (R8). If a command cannot be verified, describe the
  behavior generically instead of naming the command.

## Tasks

- [x] T1. Verify `/context` and `/compact` against the installed Claude Code
      environment. (R8)
- [x] T2. Write `reference/context-economy.md`. (R1, R2, R4, R5)
- [x] T3. Add concise `Context economy` section to
      `templates/CLAUDE.md.template`. (R3)
- [x] T4. Add README/README.html note. (R6)
- [x] T5. Add `DOCUMENTATION.html` section 15 + §13 link. (R7)
- [x] T6. Check PR 2 boxes in `todolist.md`; stage files; run
      `scripts/update-manifest.sh`.
- [x] T7. Review pass and record the review in this spec.

## Review

Reviewer checklist (kit-internal review, traceability against requirements):

- R1 ✔ `reference/context-economy.md` created: principle, practices,
  good-vs-bad table, durable-context table.
- R2 ✔ All six practices documented (`/context`, `/compact`, selective
  compacting with an example preserving decisions/status/constraints/open
  questions, subagents for noisy research, skills for long procedures,
  linked docs instead of copying into `CLAUDE.md`).
- R3 ✔ `templates/CLAUDE.md.template` gained a 7-line `Context economy`
  section (rules only, no procedure) placed before `Final rule`. The
  template stays concise, consistent with the policy itself.
- R4 ✔ Conciseness/linking guidance present in the reference file, the
  template section, and DOCUMENTATION.html §15.
- R5 ✔ MCP-heavy toolset warning present, cross-referencing
  `mcps/mcp-policy.md` and the scoped-subagent pattern.
- R6 ✔ README.md and README.html carry the short context-window note with a
  link to the reference file.
- R7 ✔ DOCUMENTATION.html §15 `Context economy` added to the Documentation
  TOC group: good/bad examples table, CLAUDE.md length guidance,
  compact/subagent/skill decision table. §13 theory row now links the new
  reference file.
- R8 ✔ `/context [all]` and `/compact [instructions]` verified against the
  official Claude Code commands reference (code.claude.com/docs/en/commands,
  fetched 2026-06-10): `/compact` confirmed to accept optional focus
  instructions; `/context` confirmed to show usage with optimization
  suggestions. Wording in the kit matches the verified behavior.
- Checks: CI consistency checks (stale spec-artifact refs, placeholder
  locations, manifest freshness) pass locally; shellcheck N/A (no scripts
  changed); manifest regenerated with the two new files.
- Safety: documentation/template-only change; nothing enabled by default,
  no external access, no secrets.

Decision: **approved**.
