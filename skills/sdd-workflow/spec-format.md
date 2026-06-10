# Spec format

Each SDD feature gets a directory:

```text
specs/<feature-slug>/
├── requirements.html
├── design.html
├── tasks.html
├── review.html
├── spec.css
└── spec.js
```

Spec files are self-contained HTML documents. When creating a new spec, instantiate each
file from the corresponding `.html.template` in `.claude/skills/sdd-workflow/templates/`
(replace every `{{PLACEHOLDER}}` token), and copy `spec.css` and `spec.js` from that same
directory into the feature folder.
All HTML spec files link to the shared stylesheet with:

```html
<link rel="stylesheet" href="spec.css">
```

and load interactivity at the bottom of `<body>` with:

```html
<script src="spec.js"></script>
```

## `requirements.html`

Purpose: define observable behavior.

Recommended sections:

1. Metadata (header table: Task ID, Feature slug, Status, Author, Human approval).
2. Summary.
3. Functional requirements (with `REQ-NNN` IDs).
4. Non-functional requirements (with `NFR-NNN` IDs).
5. Edge cases (with `EDGE-NNN` IDs).
6. Error states (with `ERR-NNN` IDs).
7. Acceptance criteria (with `AC-NNN` IDs).
8. Requirement-to-test mapping table.

## Requirements formats

### EARS

Use EARS when requirements should map cleanly to tests.

Examples:

```text
When the user runs `<command>`, the system shall print at most five notes ordered by recency.
When the user passes `--limit N` with N greater than zero, the system shall print at most N notes.
If the user passes an invalid limit, the system shall return a clear validation error.
```

### User stories

```text
As a <role>, I want <capability>, so that <benefit>.
```

Add acceptance criteria under each story.

### Given/When/Then

```text
Given <context>
When <action>
Then <expected outcome>
```

Use this when behavior is scenario-driven.

## `design.html`

Purpose: translate behavior into a technical plan.

Recommended sections:

1. Metadata (header table).
2. Technical summary.
3. Data flow (inline SVG diagram — replace the placeholder).
4. Files to change (table).
5. Files not to change (table).
6. Interfaces and contracts (use tabs for multiple languages/formats).
7. Data model changes.
8. Test design.
9. Risks and trade-offs.
10. Rollback plan.

## `tasks.html`

Purpose: give the implementer a small, ordered checklist with a milestone view.

Task rules:

- Tasks must be actionable.
- Each task should be small.
- Each task should reference requirements where possible.
- Include test tasks.
- Include validation tasks.

The ordered `<ol class="task-timeline">` list provides a visual milestone view.
Each `<li class="task-item">` can carry a status class: `done`, `in-progress`, or `blocked`.
This status class is the single mechanism for subtask progress: the implementer adds
`done` to each completed item, and the reviewer verifies it. The global task status
(spec_ready, human_approved, …) lives in `tasks.json`, never in the HTML.

## `review.html`

Purpose: record whether the implementation satisfies the spec.

Recommended sections:

1. Metadata (header table).
2. Traceability table — use `class="blocking"`, `"warning"`, or `"ok"` on `<td>` cells.
3. Commands run.
4. Findings (collapsible sections for blocking and non-blocking).
5. Decision (approved / rejected / needs_changes).
6. Notes.
