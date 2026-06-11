# SDD review checklist

The reviewer must validate the implementation against the approved spec.

## 1. Spec completeness

- [ ] `requirements.html` exists.
- [ ] `design.html` exists.
- [ ] `tasks.html` exists.
- [ ] Human approval is recorded if required.
- [ ] No unresolved TODOs remain in approved requirements unless explicitly accepted.

## 2. Requirement traceability

For every functional requirement:

- [ ] There is implementation evidence.
- [ ] There is test evidence or a documented exception.
- [ ] The behavior matches the requirement.
- [ ] Edge cases are handled.
- [ ] Error states are handled.

## 3. Design conformance

- [ ] The implementation follows `design.html`.
- [ ] Files changed are listed in the design or justified.
- [ ] Public APIs were not changed unexpectedly.
- [ ] Data/schema changes are documented.
- [ ] Rollback considerations remain valid.

## 4. Testing

- [ ] New tests were added where needed.
- [ ] Existing tests were updated only when justified.
- [ ] Tests assert behavior, not implementation details, unless appropriate.
- [ ] Tests fail for the right reason before implementation if using TDD.
- [ ] All configured tests pass, or failures are documented and accepted.
- [ ] If the project has a `run-and-verify` skill (`.claude/skills/run-and-verify/SKILL.md`), applicable checks were run through it and the evidence (commands run, results, unverified items) is recorded.

## 5. Code quality

- [ ] Code follows project conventions.
- [ ] Error handling is appropriate.
- [ ] No unrelated refactor was introduced.
- [ ] No dead code or debug output remains.
- [ ] No secrets or credentials were introduced.

## 6. Safety

- [ ] Protected files were not modified without approval.
- [ ] Destructive operations were not added without explicit design approval.
- [ ] Security-sensitive changes were reviewed.
- [ ] External inputs are validated.
- [ ] External dependency/SDK/API/framework changes carry freshness evidence (docs checked with source and date, version constraints, deprecated APIs avoided) in the design's `External dependencies and freshness` section or in the review. Purely internal changes state `None`.

## 7. Decision

Choose exactly one:

- `approved`
- `needs_changes`
- `spec_revision_required`
- `blocked`

A review cannot be `approved` if a blocking requirement has no implementation or test evidence, or if a high-risk external change (auth, payments, database migrations, cloud infrastructure, framework upgrades, security-sensitive code) lacks the required freshness evidence.
