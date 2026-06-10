# Spec folder format

Each SDD feature spec may contain:

- `requirements.html` — testable behavioral requirements.
- `design.html` — technical implementation plan.
- `tasks.html` — ordered implementation tasks.
- `assumptions.html` — explicit assumptions made during spec creation.
- `open-questions.html` — unresolved questions requiring developer input.
- `acceptance-tests.html` — acceptance-level test scenarios.
- `review.html` — written by the reviewer after implementation.
- `spec.css` — shared stylesheet (link with `<link rel="stylesheet" href="spec.css">`).
- `spec.js` — lightweight interactivity (TOC, collapsibles, tabs).

All spec files are self-contained HTML that renders correctly when opened directly from disk via the relative `spec.css` link.

If the spec was generated from a functional document, `assumptions.html`, `open-questions.html`, and `acceptance-tests.html` should be created even if some sections are empty.