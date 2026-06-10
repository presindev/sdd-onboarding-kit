---
name: git-discipline
description: Work cleanly with branches, diffs, commits, and PR descriptions without risky git actions. Use when the developer asks for commits, branches, or PR text tied to SDD tasks.
---

# Git discipline

## Purpose

Produce clean, traceable git artifacts (branches, commits, PR
descriptions) tied to SDD tasks, while keeping every mutating git action
permission-gated.

> Roadmap note (kit-internal): a later kit version adds commit/PR
> description templates and reviewer integration; this skill is
> forward-compatible with it.

## When to use

- The developer asks to commit, branch, or open a PR.
- Writing a commit message or PR description for completed SDD work.
- Inspecting repository state before starting changes.

## When not to use

- As permission to perform git operations the developer did not request.
- For resolving complex history surgery (interactive rebase, force-push
  recovery) — surface the situation and let the developer drive.

## Required inputs

- The task/spec reference the change traces to.
- The project's git policy from `CLAUDE.md` (branch naming, commit
  conventions, whether Claude may commit/push at all).

## Procedure

1. Inspect `git status` and the diff before any action; never overwrite
   uncommitted developer changes.
2. If a branch is needed, follow the project's naming convention; ask if
   none is defined.
3. Write commit messages that reference the task/spec ID and describe the
   why, following the project's convention.
4. For PRs, summarize: what changed, traceability to the spec, checks run,
   safety notes. Reuse reviewer output where available.
5. Confirm before each mutating operation unless the project's git policy
   explicitly pre-authorizes it.

## Output artifact

Commits, branches, or PR descriptions — only those explicitly requested —
plus their traceable text.

## Safety constraints

- Do not commit, push, merge, or open PRs unless asked.
- Never force-push, rewrite shared history, or skip hooks without explicit
  approval recorded in the conversation.
- Never commit secrets; check the diff for credentials before committing.
- Respect protected branches and the project's git policy at all times.
