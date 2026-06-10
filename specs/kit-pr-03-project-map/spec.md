# Kit-internal spec — PR 3: Project map artifact

> **Scope note:** kit-internal SDD spec for the `sdd-onboarding-kit`
> repository itself. Not part of the installed harness; never copied during
> onboarding (same rule as `specs/example-feature/`).

## Meta

| Field | Value |
|---|---|
| Task | PR 3 from `todolist.md` (local roadmap) |
| Status | `done` |
| Approval | Per the agreed workflow (2026-06-10): the developer merges each roadmap GitHub PR before the next is implemented; merging roadmap PR 2 (GitHub #6) and the developer's explicit "continue with PR 3" authorized this implementation. |

## Requirements

R1. The kit SHALL provide `templates/project-map.md.template` with sections
for: directory tree; key entrypoints; package/build/test/lint commands;
framework/runtime assumptions; important docs; protected areas;
spec/task/history locations; generated files and files Claude must not edit
without approval.

R2. Onboarding SHALL generate a project-specific map, defaulting to
`.claude/context/project-map.md` (alternative: `docs/project-map.md` if the
developer prefers docs-visible artifacts). If generation is deferred, a
clear TODO must be recorded.

R3. `templates/CLAUDE.md.template` SHALL link to the project map instead of
embedding a directory tree.

R4. The kit SHALL state a maintenance rule: update the project map when the
repository structure changes significantly (new top-level directories,
moved entrypoints, changed commands, new protected areas).

R5. The map SHALL stay concise (consistent with the context-economy policy):
shallow annotated tree, no exhaustive file listing, no secrets.

R6. `questions.md` SHALL ask where the project map should live and whether
to generate it during onboarding.

R7. `instructions.md` and `output-project-structure.md` SHALL reflect the
new artifact (generation rules, expected structure, success criteria).

R8. `README.md` (and `README.html`) SHALL carry a short mention that
onboarding produces a project map.

R9. `DOCUMENTATION.html` SHALL gain a full `Project map` section with an
example map and guidance on when to update it.

## Design

Files changed:

| File | Change |
|---|---|
| `templates/project-map.md.template` | New file: template with the eight required sections, `{{...}}`-style placeholder tokens, and an embedded maintenance rule (R1, R4, R5). |
| `templates/CLAUDE.md.template` | New short `Project map` section linking the `PROJECT_MAP_PATH` placeholder with the maintenance rule (R3, R4). |
| `questions.md` | §12 gains two questions: map location and generate-now vs defer (R6). |
| `instructions.md` | Phase 3 tree gains `.claude/context/project-map.md`; Phase 4 gains a `Project map` generation rule; Phase 5 gains a validation item (R2, R7). |
| `output-project-structure.md` | Tree gains the map; success criteria gain item 12 (R7). |
| `README.md` + `README.html` | One short sentence next to the context-window note (R8). |
| `DOCUMENTATION.html` | New section `16. Project map` in the Documentation TOC group, with example and update guidance (R9). |
| `todolist.md` | Check PR 3 boxes. |
| `manifest.md` | Regenerate. |

Decisions:

- Template lives in `templates/` (not `.claude/context/` inside the kit):
  consistent with `CLAUDE.md.template` and the other root-level templates;
  the kit's own `.claude/` is the kit's harness, not source material.
- Default generated location is `.claude/context/project-map.md`: it is
  harness context, not user-facing docs; `docs/project-map.md` is offered
  for teams that want it visible outside `.claude/`.
- `CLAUDE.md.template` uses a `PROJECT_MAP_PATH` placeholder so the
  link survives either location choice.
- The map is generated during onboarding from Phase 1 inspection data, so
  it costs no extra questions beyond location/defer.

## Tasks

- [x] T1. Write `templates/project-map.md.template`. (R1, R4, R5)
- [x] T2. Add `Project map` section to `templates/CLAUDE.md.template`. (R3, R4)
- [x] T3. Add onboarding questions to `questions.md` §12. (R6)
- [x] T4. Update `instructions.md` Phases 3–5. (R2, R7)
- [x] T5. Update `output-project-structure.md` tree + success criteria. (R7)
- [x] T6. Add README.md / README.html note. (R8)
- [x] T7. Add `DOCUMENTATION.html` section 16 + TOC entry. (R9)
- [x] T8. Check PR 3 boxes in `todolist.md`; stage files; run
      `scripts/update-manifest.sh`.
- [x] T9. Review pass and record the review in this spec.

## Review

Reviewer checklist (kit-internal review, traceability against requirements):

- R1 ✔ `templates/project-map.md.template` has all eight required sections
  (directory tree, entrypoints, commands, framework/runtime assumptions,
  important docs, protected areas, SDD locations, generated/do-not-edit
  files) using the kit's `{{...}}`-style placeholder convention.
- R2 ✔ `instructions.md` Phase 4 rule generates the map by default at
  `.claude/context/project-map.md`, honors `docs/project-map.md`, and
  requires a recorded TODO when deferred; Phase 5 validates it.
- R3 ✔ `CLAUDE.md.template` links the `PROJECT_MAP_PATH` placeholder; no directory tree
  is embedded in the template.
- R4 ✔ Maintenance rule appears in the map template header, the
  `CLAUDE.md.template` section, and DOCUMENTATION.html §16.
- R5 ✔ Conciseness rules (depth-limited tree, no exhaustive listing, no
  secrets) embedded in the template header and the Phase 4 rule;
  cross-referenced with `reference/context-economy.md`.
- R6 ✔ `questions.md` §12 asks location (default `.claude/context/`) and
  generate-now vs defer-with-TODO.
- R7 ✔ `output-project-structure.md` tree includes
  `.claude/context/project-map.md`; success criterion 12 added.
- R8 ✔ README.md and README.html carry the one-line note next to the
  context-window note.
- R9 ✔ DOCUMENTATION.html §16 added to the Documentation TOC group:
  purpose, location options, contents, compact example map, and a
  when-to-update list.
- Checks: CI consistency checks (stale spec-artifact refs, placeholder
  locations, manifest freshness) pass locally; shellcheck N/A (no scripts
  changed); `{{...}}`-style placeholder tokens only under `templates/` (allowlisted);
  manifest regenerated with the two new files.
- Safety: documentation/template-only change; map generation excludes
  secrets by rule; nothing enabled by default, no external access.

Decision: **approved**.
