# Spec format

Each SDD feature gets a directory:

```text
specs/<feature-slug>/
├── requirements.md
├── design.md
├── tasks.md
└── review.md
```

## `requirements.md`

Purpose: define observable behavior.

Recommended sections:

1. Metadata.
2. Summary.
3. Functional requirements.
4. Non-functional requirements.
5. Edge cases.
6. Error states.
7. Acceptance criteria.
8. Requirement-to-test mapping.

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

## `design.md`

Purpose: translate behavior into a technical plan.

Recommended sections:

1. Metadata.
2. Technical summary.
3. Files to change.
4. Files not to change.
5. Interfaces and contracts.
6. Data model changes.
7. Test design.
8. Risks and trade-offs.
9. Rollback plan.

## `tasks.md`

Purpose: give the implementer a small, ordered checklist.

Task rules:

- Tasks must be actionable.
- Each task should be small.
- Each task should reference requirements where possible.
- Include test tasks.
- Include validation tasks.

Example:

```md
- [ ] T1: Add tests for `REQ-001` and `REQ-002`.
- [ ] T2: Add CLI parser support for `--limit`.
- [ ] T3: Implement limit validation.
- [ ] T4: Run `scripts/run-tests.sh`.
```

## `review.md`

Purpose: record whether the implementation satisfies the spec.

Recommended sections:

1. Metadata.
2. Traceability table.
3. Commands run.
4. Findings.
5. Decision.
6. Follow-ups.
