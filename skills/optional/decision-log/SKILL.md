---
name: decision-log
description: Record durable architectural and workflow decisions in the project's decision log. Use when a spec, review, or discussion settles something future sessions must not re-litigate.
---

# Decision log

## Purpose

Make significant decisions survive context compaction and new sessions by
recording them in versioned project files instead of chat history.

> Roadmap note (kit-internal): a later kit version formalizes the
> `decisions/` structure and ADR support; this skill is forward-compatible
> with it.

## When to use

- A spec or review settles an architectural choice (and especially when an
  alternative was explicitly rejected).
- A workflow rule is agreed with the developer ("from now on, X").
- The same question keeps being re-asked across sessions.

## When not to use

- Trivial choices with no future consequence (naming a local variable,
  one-off formatting).
- Speculative conclusions not yet confirmed by the developer.
- Anything containing secrets or sensitive operational data.

## Required inputs

- The decision, its context, and the alternatives considered.
- Where the project records decisions: `decisions/` files (default
  `decisions/answers.md` exists from onboarding) or `docs/adr/` if the
  project uses ADRs.
- The source task/spec/review the decision came from.

## Procedure

1. Confirm the decision is durable and non-trivial.
2. Propose the entry to the developer (one short paragraph: decision,
   context, alternatives rejected, consequences, source reference).
3. On approval, append it to the configured decision file with a date.
4. If the decision contradicts an earlier entry, mark the old entry as
   superseded rather than deleting it.

## Output artifact

An appended entry in the project's decision log (`decisions/*.md` or
`docs/adr/`).

## Safety constraints

- Propose, do not overproduce: when in doubt, ask whether it is worth
  logging.
- Never log secrets, credentials, or personal data.
- Decision logs are project memory; do not write to global Claude memory.
