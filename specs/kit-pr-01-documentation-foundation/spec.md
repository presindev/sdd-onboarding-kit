# Kit-internal spec — PR 1: Documentation foundation and English canonical theory

> **Scope note:** this is a kit-internal SDD spec for changes to the
> `sdd-onboarding-kit` repository itself. It is **not** part of the harness
> installed into target projects and must never be copied during onboarding
> (same rule as `specs/example-feature/`).

## Meta

| Field | Value |
|---|---|
| Task | PR 1 from `todolist.md` (local roadmap) |
| Status | `done` |
| Approval | Developer instruction on 2026-06-10: "read todolist.md and start implementing". Approval covers PR 1 only; later PRs require their own approval. |
| Spec author / implementer / reviewer | Claude Code (kit-internal change, single session) |

## Requirements

R1. The kit SHALL have a canonical human-readable documentation page at
`DOCUMENTATION.html` (already existed; this PR extends it).

R2. `DOCUMENTATION.html` SHALL contain a `Documentation model` section that
describes the documentation hierarchy:
`README.md` (quick start) → `DOCUMENTATION.html` (full operational docs) →
`reference/` (theory and policy) → skills (procedures) → agents (roles).

R3. `DOCUMENTATION.html` SHALL contain a `Language policy` section stating
that reusable kit files are in English while generated project-specific
artifacts may use the target project's preferred language.

R4. The `Documentation model` section SHALL link to the SDD theory, harness
engineering, onboarding instructions, agents, skills, hooks policy, and MCP
policy files.

R5. `reference/sdd-theory.md` SHALL be in English. The Spanish version SHALL
no longer exist in the repository. The translation SHALL be a coherent
rewrite, not a mechanical word-for-word translation.

R6. All internal references to the theory file SHALL remain valid
(`instructions.md`, `manifest.md` reference it by path only, so an in-place
translation keeps them valid).

R7. `README.md` SHALL link to `DOCUMENTATION.html` prominently and state
that English is canonical for reusable kit docs.

R8. `README.html` (the rendered mirror of `README.md`) SHALL reflect the
same changes.

## Design

Files changed:

| File | Change |
|---|---|
| `reference/sdd-theory.md` | Translate in place to English (satisfies R5 + R6: path unchanged, Spanish version gone). |
| `DOCUMENTATION.html` | Add a new `Documentation` TOC group with sections `13. Documentation model` and `14. Language policy` (appended; existing section numbers and anchors untouched). |
| `README.md` | Add a `Documentation` section after the intro with the hierarchy and the language-policy note. |
| `README.html` | Mirror the `README.md` changes. |
| `specs/kit-pr-01-documentation-foundation/spec.md` | This spec. |
| `todolist.md` | Check PR 1 boxes (local-only file). |
| `manifest.md` | Regenerated via `scripts/update-manifest.sh`. |

Decisions:

- New `DOCUMENTATION.html` sections are appended (13, 14) instead of inserted
  early, to avoid renumbering ten existing sections; anchors are id-based, so
  links remain stable either way.
- Verified before implementation that `reference/harness-engineering.md` and
  `reference/claude-code-primitives.md` are already English; only
  `sdd-theory.md` contained Spanish (grep over the whole kit).
- Spanish material is fully replaced, so no "legacy/non-canonical" labelling
  is needed (acceptance criterion "Spanish material, if retained" — none is
  retained).

## Tasks

- [x] T1. Translate `reference/sdd-theory.md` to English in place. (R5, R6)
- [x] T2. Add `Documentation model` + `Language policy` sections and TOC
      entries to `DOCUMENTATION.html` with links to theory, harness
      engineering, instructions, agents, skills, hooks, MCP policy. (R1–R4)
- [x] T3. Update `README.md`: documentation hierarchy + canonical-language
      note + prominent link to `DOCUMENTATION.html`. (R7)
- [x] T4. Mirror README changes into `README.html`. (R8)
- [x] T5. Stage new files and run `scripts/update-manifest.sh`.
- [x] T6. Check PR 1 boxes in `todolist.md`.
- [x] T7. Review pass (see below).

## Review

Reviewer checklist (kit-internal review, traceability against requirements):

- R1 ✔ `DOCUMENTATION.html` exists and remains the canonical page; README
  links to it from the new Documentation section and the key-files table.
- R2 ✔ Section `13. Documentation model` added with the hierarchy table
  covering README, DOCUMENTATION.html, `reference/`, skills, agents (kit
  source paths and installed `.claude/` paths both shown).
- R3 ✔ Section `14. Language policy` added: English canonical for kit files;
  generated project artifacts may use the project's language.
- R4 ✔ Documentation model section links to `reference/sdd-theory.md`,
  `reference/harness-engineering.md`, `reference/claude-code-primitives.md`,
  `instructions.md`, `questions.md`, `agents/`, `skills/sdd-workflow/`,
  `hooks/hooks-policy.md`, `mcps/mcp-policy.md`.
- R5 ✔ `reference/sdd-theory.md` is now English; content reviewed for
  coherence (rewritten section by section, not machine-literal). No Spanish
  text remains in the repository (grep for Spanish diacritics/stop-words
  returns nothing).
- R6 ✔ References in `instructions.md` and `manifest.md` are path-only and
  still valid.
- R7 ✔ README has the Documentation section, the canonical-language note,
  and the link.
- R8 ✔ README.html mirrors the change.
- Checks: `bash scripts/update-manifest.sh` ran successfully; manifest
  includes this spec. The kit has no automated test suite beyond CI checks;
  nothing in this PR changes scripts or hooks.
- Safety: documentation-only change; no hooks enabled, no MCPs configured,
  no external access, no secrets or personal data introduced.

Decision: **approved**.
