# Summary of the source transcript

The source transcript describes a Claude Code setup for Spec Driven Development.

## Main ideas

1. Better models do not automatically produce better code. The surrounding workflow and harness matter.
2. Harness Engineering means automating a chosen software workflow with AI.
3. SDD is one possible workflow: specify first, implement second, validate third.
4. The specification should become the source of truth.
5. The human should remain in the loop, especially before implementation and when reviewing tests.
6. Context should be externalized into files so agents do not depend on a long chat history.
7. The proposed setup uses specialized agents:
   - Spec Author
   - Implementer
   - Reviewer
   - Leader / orchestrator
8. A feature spec is split into:
   - `requirements.md`
   - `design.md`
   - `tasks.md`
9. Requirements can be written in EARS notation so that they map cleanly to tests.
10. The task lifecycle pauses after spec generation until a human approves it.
11. MCPs, ticketing systems, commits, branches and pull requests are optional extensions of the harness.
12. The developer should customize the harness to match their real workflow instead of adopting someone else's opinionated flow blindly.

## Implications for this kit

This kit therefore:

- does not hardcode a single tool stack;
- asks the developer before configuring MCPs or hooks;
- treats local Markdown/JSON files as the minimum viable setup;
- separates onboarding instructions from final project instructions;
- uses modular files so Claude Code can load only what it needs;
- keeps human approval as the safe default.
