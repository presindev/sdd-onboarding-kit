# SDD examples

A complete, rendered example spec for this feature lives in the kit under
`specs/example-feature/` (all seven HTML files plus `spec.css`/`spec.js`,
filled in end-to-end through review). Open any of those files in a browser to
see the target output. The fragments below are quick references.

## Example task entry

```json
{
  "id": "FEAT-007",
  "title": "Add recent notes CLI command",
  "slug": "cli-recent-notes",
  "description": "Add a CLI command that prints recent notes with an optional limit.",
  "sdd": true,
  "status": "pending",
  "spec_path": "specs/cli-recent-notes",
  "approval": {
    "required": true,
    "approved_by": null,
    "approved_at": null,
    "notes": null
  }
}
```

## Example EARS requirements

```md
- `REQ-001`: When the user runs `notes recent` without `--limit`, the system shall print at most five notes ordered by descending creation time.
- `REQ-002`: When the user runs `notes recent --limit N` with N greater than zero, the system shall print at most N notes.
- `REQ-003`: If the user provides a non-positive limit, the system shall return a validation error and not print notes.
```

## Example design excerpt

```md
## Files to change

| File | Change | Reason |
|---|---|---|
| `src/cli.py` | Add `recent` subcommand and `--limit` argument | CLI entrypoint |
| `src/notes.py` | Add `get_recent_notes(limit)` | Business logic |
| `tests/test_cli_recent.py` | Add CLI behavior tests | Requirement coverage |
```

## Example tasks

Tasks in `tasks.html` are `<li class="task-item">` entries inside the `<ol class="task-timeline">`. Completed items get `class="task-item done"` (also available: `in-progress`, `blocked`):

```html
<ol class="task-timeline">
  <li class="task-item done">
    <div class="task-item-header">
      <span class="req-id t">T1</span>
      <strong>Add tests for default recent note limit (<code>REQ-001</code>).</strong>
    </div>
    <div class="task-item-body">Write the failing test first; assert at most five notes ordered by recency.</div>
  </li>
  <li class="task-item in-progress">
    <div class="task-item-header">
      <span class="req-id t">T2</span>
      <strong>Add tests for custom positive limit (<code>REQ-002</code>).</strong>
    </div>
    <div class="task-item-body">Cover <code>--limit N</code> for N &gt; 0.</div>
  </li>
  <li class="task-item">
    <div class="task-item-header">
      <span class="req-id t">T3</span>
      <strong>Add tests for invalid limit (<code>REQ-003</code>).</strong>
    </div>
    <div class="task-item-body">Non-positive limits must produce a validation error.</div>
  </li>
  <li class="task-item">
    <div class="task-item-header">
      <span class="req-id t">T4</span>
      <strong>Implement <code>get_recent_notes(limit)</code>.</strong>
    </div>
    <div class="task-item-body">Business logic in <code>src/notes.py</code>.</div>
  </li>
  <li class="task-item">
    <div class="task-item-header">
      <span class="req-id t">T5</span>
      <strong>Register <code>notes recent</code> CLI command.</strong>
    </div>
    <div class="task-item-body">Wire the subcommand and <code>--limit</code> argument in <code>src/cli.py</code>.</div>
  </li>
  <li class="task-item">
    <div class="task-item-header">
      <span class="req-id t">T6</span>
      <strong>Run validation commands.</strong>
    </div>
    <div class="task-item-body">Tests, lint and typecheck as configured in <code>CLAUDE.md</code>.</div>
  </li>
</ol>
```

## Example: editing open-questions.html during spec_draft

This is a valid and expected operation. The `block-implementation-before-approval` hook must allow it.

A task in `spec_draft` has a blocking question card in `open-questions.html`:

```html
<div class="card blocking-yes" id="q1">
  <div class="card-header">
    <span class="req-id err">Q1</span>
    <span class="card-title">Authentication mechanism</span>
    <span class="badge badge-blocking">Blocking</span>
  </div>
  <div class="card-body">
    <dl class="card-fields">
      <dt>Question</dt> <dd>Should the endpoint use API key or OAuth2?</dd>
      <dt>Blocking</dt> <dd>Yes</dd>
      <dt>Decision</dt> <dd><span class="badge badge-pending">Pending</span></dd>
    </dl>
  </div>
</div>
```

The spec-author (or developer) fills in the decision and moves the card to the `#resolved-questions` section:

```html
<div class="card" id="q1">
  <div class="card-header">
    <span class="req-id">Q1</span>
    <span class="card-title">Authentication mechanism</span>
    <span class="badge badge-ok">Resolved</span>
  </div>
  <div class="card-body">
    <dl class="card-fields">
      <dt>Question</dt>    <dd>Should the endpoint use API key or OAuth2?</dd>
      <dt>Decision</dt>    <dd>API key for the MVP. OAuth2 will be addressed in a follow-up task.</dd>
      <dt>Resolved by</dt> <dd>developer</dd>
      <dt>Resolved at</dt> <dd>2026-06-10</dd>
    </dl>
  </div>
</div>
```

After all blocking questions are resolved, the spec-author sets the task status to `spec_ready` and requests human approval. The hook must not block this edit — `open-questions.html` is a spec file, not an implementation file.

## Example review traceability

The traceability table in `review.html` uses `class="ok"`, `"warning"`, or `"blocking"` on each evidence `<td>`:

```html
<table>
  <thead>
    <tr><th>Requirement</th><th>Implemented?</th><th>Tested?</th><th>Evidence</th></tr>
  </thead>
  <tbody>
    <tr>
      <td><span class="req-id">REQ-001</span></td>
      <td class="ok">Yes</td>
      <td class="ok">Yes</td>
      <td><code>src/cli.py</code>, <code>tests/test_cli_recent.py::test_default_limit</code></td>
    </tr>
    <tr>
      <td><span class="req-id">REQ-002</span></td>
      <td class="ok">Yes</td>
      <td class="ok">Yes</td>
      <td><code>src/cli.py</code>, <code>tests/test_cli_recent.py::test_custom_limit</code></td>
    </tr>
    <tr>
      <td><span class="req-id">REQ-003</span></td>
      <td class="ok">Yes</td>
      <td class="warning">Partial</td>
      <td><code>src/cli.py</code>; missing test for limit = 0</td>
    </tr>
  </tbody>
</table>
```
