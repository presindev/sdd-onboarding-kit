# SDD examples

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

```md
- [ ] `T1`: Add tests for default recent note limit (`REQ-001`).
- [ ] `T2`: Add tests for custom positive limit (`REQ-002`).
- [ ] `T3`: Add tests for invalid limit (`REQ-003`).
- [ ] `T4`: Implement `get_recent_notes(limit)`.
- [ ] `T5`: Register `notes recent` CLI command.
- [ ] `T6`: Run validation commands.
```

## Example review traceability

```md
| Requirement | Implemented? | Tested? | Evidence |
|---|---:|---:|---|
| REQ-001 | Yes | Yes | `src/cli.py`, `tests/test_cli_recent.py::test_default_limit` |
| REQ-002 | Yes | Yes | `src/cli.py`, `tests/test_cli_recent.py::test_custom_limit` |
| REQ-003 | Yes | Yes | `src/cli.py`, `tests/test_cli_recent.py::test_invalid_limit` |
```
