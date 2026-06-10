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
│   │       ├── examples.md
│   │       └── templates/
│   │           ├── requirements.html.template
│   │           ├── design.html.template
│   │           ├── tasks.html.template
│   │           ├── review.html.template
│   │           ├── acceptance-tests.html.template
│   │           ├── assumptions.html.template
│   │           ├── open-questions.html.template
│   │           ├── spec.css
│   │           └── spec.js
│   ├── hooks/
│   │   └── README.md
│   └── settings.json
├── specs/
│   └── <feature-slug>/
│       ├── requirements.html
│       ├── design.html
│       ├── tasks.html
│       ├── assumptions.html
│       ├── open-questions.html
│       ├── acceptance-tests.html
│       ├── review.html
│       ├── spec.css
│       └── spec.js
├── decisions/
│   └── answers.md
├── tasks.json
├── history.html
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
├── docs/architecture.html
└── docs/conventions.html
```

Local files should still exist unless the developer explicitly chooses a fully external tracker.

## Success criteria

The onboarding is complete when:

1. `CLAUDE.md` exists and reflects this specific project.
2. The SDD skill exists under `.claude/skills/sdd-workflow/`.
3. The HTML spec templates (plus `spec.css` and `spec.js`) exist under `.claude/skills/sdd-workflow/templates/`.
4. The four subagents exist under `.claude/agents/`.
5. There is a task storage mechanism.
6. There is a spec storage mechanism.
7. `decisions/answers.md` records the developer's onboarding answers.
8. There is a validation command or documented TODO.
9. Hooks are either explicitly enabled or explicitly left disabled.
10. MCPs are either explicitly configured or explicitly left unconfigured.
11. No generated file contains unresolved placeholders without a TODO explaining why (the `.html.template` files under `.claude/skills/sdd-workflow/templates/` are exempt — their placeholders are instantiated per feature).
