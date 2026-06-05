# Spec folder format

Each SDD feature spec may contain:

- `requirements.md` — testable behavioral requirements.
- `design.md` — technical implementation plan.
- `tasks.md` — ordered implementation tasks.
- `assumptions.md` — explicit assumptions made during spec creation.
- `open-questions.md` — unresolved questions requiring developer input.
- `acceptance-tests.md` — acceptance-level test scenarios.

If the spec was generated from a functional document, `assumptions.md`, `open-questions.md`, and `acceptance-tests.md` should be created even if some sections are empty.