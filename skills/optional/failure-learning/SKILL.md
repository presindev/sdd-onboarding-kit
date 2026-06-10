---
name: failure-learning
description: Propose a reusable lesson after a meaningful implementation mistake. Use when a wrong assumption, convention violation, or repeated error was corrected by tests, the reviewer, or the developer.
---

# Failure learning

## Purpose

Capture reusable lessons from real mistakes so they are not repeated —
always as a **proposal** to the developer, never as a silent memory write.

> Roadmap note (kit-internal): a later kit version adds the full memory
> policy, entry template, and advisory hooks; this v1 records lessons in
> project files only.

## When to use

A memorable failure happened, such as:

- failed tests caused by a wrong project convention;
- the reviewer found an architectural violation;
- the developer corrected a repeated assumption;
- the wrong command/tool was used;
- code was edited outside the approved scope;
- the same error happened more than once.

## When not to use

- One-off syntax mistakes or typos.
- Speculative conclusions the developer has not confirmed.
- Anything involving secrets or personal/private data.

## Required inputs

- What went wrong, the root cause, and the correction.
- The source task/spec/review where it happened.

## Procedure

1. Draft a short entry: what went wrong, root cause, rule to remember,
   where it applies (and where it does not), source reference.
2. Propose it to the developer and ask where it should live:
   project decision log / review notes only / revise wording / discard.
3. Write it only where the developer chose.
4. If the same lesson is proposed twice, that is a signal it belongs in a
   more visible place (e.g. `CLAUDE.md` rules) — suggest that explicitly.

## Output artifact

An approved lesson entry in the project's decision log or the task's
review notes — nothing if the developer declines.

## Safety constraints

- Never write any memory (project or global) without explicit approval of
  the specific entry text.
- Global Claude memory is out of scope for this skill; project files only.
- Never record secrets, credentials, or personal data in a lesson.
