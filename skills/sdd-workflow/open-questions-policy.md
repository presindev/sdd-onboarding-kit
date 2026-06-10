# Open Questions Policy

## Purpose

This policy defines how Claude Code should identify, record, prioritize, and resolve open questions during Spec Driven Development.

Open questions prevent hidden ambiguity from becoming incorrect code.

---

## Core rule

If a missing decision could materially change the product behavior, architecture, tests, security model, data model, or developer workflow, Claude Code must record it as an open question.

Do not bury important questions in chat.

Do not proceed to implementation while blocking questions remain unresolved.

---

## Where open questions belong

Open questions must be written in:

```text
specs/<feature-slug>/open-questions.html
```

For onboarding-level decisions, use:

```text
decisions/answers.md
```

and keep unresolved onboarding questions in the relevant onboarding notes.

---

## Blocking vs non-blocking questions

Every question must be classified as:

```text
blocking
```

or:

```text
non-blocking
```

### Blocking questions

A blocking question must be answered before implementation.

Examples:

- Who is allowed to access this data?
- Should this feature modify existing records?
- What is the source of truth for this field?
- Is this a breaking API change?
- Should this create a database migration?
- What command runs the test suite?
- Should human approval be required before implementation?
- Should this feature use an external service?

### Non-blocking questions

A non-blocking question may remain unresolved for a draft spec if the assumption is safe and explicit.

Examples:

- What should the exact empty-state copy be?
- Should the CLI help text say “recent” or “latest”?
- Should the output include a trailing newline?
- Should the internal helper function be named one way or another?

Non-blocking questions should still be recorded.

---

## Required question format

Each question in `open-questions.html` is a card inside the `#open-questions` section, following the structure of the `open-questions.html` template. Add `class="blocking-yes"` to the `.card` for blocking questions, and use `badge-blocking` or `badge-warning` accordingly:

```html
<div class="card blocking-yes" id="q1">
  <div class="card-header">
    <span class="req-id err">Q1</span>
    <span class="card-title">Short title</span>
    <span class="badge badge-blocking">Blocking</span>
  </div>
  <div class="card-body">
    <dl class="card-fields">
      <dt>Question</dt>                          <dd>The question that needs to be answered.</dd>
      <dt>Why it matters</dt>                    <dd>What decision depends on this answer.</dd>
      <dt>Blocking</dt>                          <dd>Yes | No</dd>
      <dt>Default assumption if not answered</dt><dd>Optional. Only include if safe.</dd>
      <dt>Affected files / sections</dt>         <dd><code>requirements.html</code>, <code>design.html</code>, <code>tasks.html</code></dd>
      <dt>Related requirements</dt>              <dd>REQ-001</dd>
      <dt>Decision</dt>                          <dd><span class="badge badge-pending">Pending</span></dd>
      <dt>Resolved by</dt>                       <dd>Pending</dd>
      <dt>Resolved at</dt>                       <dd>Pending</dd>
    </dl>
  </div>
</div>
```

Once answered, move the card to the `#resolved-questions` (or `#deferred-questions`) section and update its fields:

```html
<dt>Decision</dt>    <dd>Developer's decision.</dd>
<dt>Resolved by</dt> <dd>developer</dd>
<dt>Resolved at</dt> <dd>YYYY-MM-DD</dd>
```

with the header badge changed to `<span class="badge badge-ok">Resolved</span>`.

---

## Categories of open questions

Use categories when helpful.

Recommended categories:

```text
Product behavior
Permissions and security
Data model
API/CLI contract
UX/copy
Validation and testing
Architecture
External integrations
Task management
Hooks and automation
MCPs
Git workflow
```

---

## When to stop and ask immediately

Claude Code must stop and ask the developer immediately if a blocking question prevents writing a meaningful spec.

Examples:

- the feature goal is unclear;
- the main actor is unclear;
- the system boundary is unclear;
- the data source is unknown;
- security/permission behavior is unspecified;
- the feature could require a destructive migration;
- the task conflicts with existing project architecture;
- the requested change could break existing public APIs.

---

## When to continue with a draft

Claude Code may continue with a draft spec if:

- the ambiguity is low or medium risk;
- the assumption is explicit;
- the assumption is reversible;
- the open question is non-blocking;
- the spec can still be reviewed meaningfully.

In that case, record the question and any default assumption.

---

## Relationship to assumptions

Use an open question when developer input is needed.

Use an assumption when Claude Code can safely proceed with a draft.

Some entries may appear in both files:

- `open-questions.html` records the decision still needed.
- `assumptions.html` records the temporary assumption used for the draft.

Example, in `open-questions.html`:

```html
<div class="card" id="q2">
  <div class="card-header">
    <span class="req-id">Q2</span>
    <span class="card-title">Empty-state copy</span>
    <span class="badge badge-warning">Non-blocking</span>
  </div>
  <div class="card-body">
    <dl class="card-fields">
      <dt>Question</dt>                          <dd>What exact message should be shown when no notes exist?</dd>
      <dt>Blocking</dt>                          <dd>No</dd>
      <dt>Default assumption if not answered</dt><dd>Use "No notes found."</dd>
      <dt>Decision</dt>                          <dd><span class="badge badge-pending">Pending</span></dd>
    </dl>
  </div>
</div>
```

And in `assumptions.html`:

```html
<div class="card risk-low" id="a2">
  <div class="card-header">
    <span class="req-id">A2</span>
    <span class="card-title">Empty-state copy</span>
    <span class="badge badge-pending">Pending</span>
  </div>
  <div class="card-body">
    <dl class="card-fields">
      <dt>Assumption</dt>            <dd>Use "No notes found." as the empty-state message.</dd>
      <dt>Risk level</dt>            <dd>Low</dd>
      <dt>Blocks implementation</dt> <dd>No</dd>
    </dl>
  </div>
</div>
```

---

## Status behavior

The presence of open questions affects task status.

### If blocking questions exist

Task status should be:

```text
spec_draft
```

Claude Code must not implement.

### If only non-blocking questions exist

Task status may be:

```text
spec_ready
```

but the final response must mention unresolved non-blocking questions.

### If no open questions exist

Task status may be:

```text
spec_ready
```

assuming requirements, design and tasks are complete.

---

## Human approval behavior

Human approval of a spec should resolve or explicitly accept all blocking questions.

Before moving a task to:

```text
human_approved
```

Claude Code must verify:

- no blocking questions remain pending;
- assumptions have been accepted, corrected, or removed;
- the developer understands any remaining non-blocking questions.

---

## Implementer behavior

The `implementer` agent must read `open-questions.html`.

If any question has:

```text
Blocking: Yes
Decision: Pending
```

the implementer must stop.

The implementer must not answer product, security, architecture, or workflow questions by itself.

---

## Reviewer behavior

The `reviewer` agent must check:

- whether implementation proceeded despite unresolved blocking questions;
- whether decisions in `open-questions.html` were reflected in code and tests;
- whether new questions emerged during implementation;
- whether unresolved questions require returning to `spec_draft`.

---

## Examples

### Good blocking question

```html
<div class="card blocking-yes" id="q1">
  <div class="card-header">
    <span class="req-id err">Q1</span>
    <span class="card-title">User visibility scope</span>
    <span class="badge badge-blocking">Blocking</span>
  </div>
  <div class="card-body">
    <dl class="card-fields">
      <dt>Question</dt>                          <dd>Should users see only their own notes or all notes in the system?</dd>
      <dt>Why it matters</dt>                    <dd>This determines authorization behavior and data filtering.</dd>
      <dt>Blocking</dt>                          <dd>Yes</dd>
      <dt>Default assumption if not answered</dt><dd>None. This must be decided by the developer.</dd>
      <dt>Affected files / sections</dt>         <dd><code>requirements.html</code>, <code>design.html</code>, <code>tasks.html</code></dd>
      <dt>Related requirements</dt>              <dd>REQ-002</dd>
      <dt>Decision</dt>                          <dd><span class="badge badge-pending">Pending</span></dd>
    </dl>
  </div>
</div>
```

### Good non-blocking question

```html
<div class="card" id="q2">
  <div class="card-header">
    <span class="req-id">Q2</span>
    <span class="card-title">Empty-state copy</span>
    <span class="badge badge-warning">Non-blocking</span>
  </div>
  <div class="card-body">
    <dl class="card-fields">
      <dt>Question</dt>                          <dd>What exact message should be displayed when no notes exist?</dd>
      <dt>Why it matters</dt>                    <dd>This affects user-facing copy but not the core behavior.</dd>
      <dt>Blocking</dt>                          <dd>No</dd>
      <dt>Default assumption if not answered</dt><dd>Use "No notes found."</dd>
      <dt>Affected files / sections</dt>         <dd><code>requirements.html</code>, <code>acceptance-tests.html</code></dd>
      <dt>Related requirements</dt>              <dd>REQ-004</dd>
      <dt>Decision</dt>                          <dd><span class="badge badge-pending">Pending</span></dd>
    </dl>
  </div>
</div>
```

### Bad question

```html
<p>How should this work?</p>
```

This is too vague and not actionable.