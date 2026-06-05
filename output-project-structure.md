# Expected project structure after onboarding

After the onboarding is complete, the target repository should contain a project-specific SDD harness.

## Minimal local-file setup

```text
<project>/
├── CLAUDE.md
├── .claude/
│   ├── agents/
│   │   ├── leader.md
│   │   ├── spec-author.md
│   │   ├── implementer.md
│   │   └── reviewer.md
│   ├── skills/
│   │   └── sdd-workflow/
│   │       ├── SKILL.md
│   │       ├── workflow.md
│   │       ├── spec-format.md
│   │       ├── task-state-machine.md
│   │       ├── review-checklist.md
│   │       ├── intake-from-functional-doc.md
│   │       ├── assumptions-policy.md
│   │       ├── open-questions-policy.md
│   │       └── examples.md
│   ├── hooks/
│   │   └── README.md
│   └── settings.json
├── specs/
│   └── <feature-slug>/
│       ├── requirements.md
│       ├── design.md
│       ├── tasks.md
│       ├── assumptions.md
│       ├── open-questions.md
│       ├── acceptance-tests.md
│       └── review.md
├── tasks.json
├── history.md
└── scripts/
    ├── init.sh
    ├── run-tests.sh
    ├── run-lint.sh
    └── validate-sdd-structure.sh
```

## Optional MCP-enabled setup

If the developer selects external task management or knowledge sources, the project may also contain:

```text
<project>/
├── .mcp.json
├── docs/adr/
├── docs/architecture.md
└── docs/conventions.md
```

Local files should still exist unless the developer explicitly chooses a fully external tracker.

## Success criteria

The onboarding is complete when:

1. `CLAUDE.md` exists and reflects this specific project.
2. The SDD skill exists under `.claude/skills/sdd-workflow/`.
3. The four subagents exist under `.claude/agents/`.
4. There is a task storage mechanism.
5. There is a spec storage mechanism.
6. There is a validation command or documented TODO.
7. Hooks are either explicitly enabled or explicitly left disabled.
8. MCPs are either explicitly configured or explicitly left unconfigured.
9. No generated file contains unresolved placeholders without a TODO explaining why.
