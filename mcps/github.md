# GitHub MCP notes

Use a GitHub MCP or GitHub CLI integration when the project wants Claude Code to work with:

- GitHub Issues;
- Pull Requests;
- labels;
- milestones;
- review comments;
- repository metadata.

## Recommended SDD mapping

| SDD concept | GitHub concept |
|---|---|
| Task | Issue |
| Spec status | Issue label or project field |
| Implementation | Branch / commits |
| Review | Pull request review |
| Done | Merged PR or closed issue |

## Questions before configuring

1. Should tasks live primarily in GitHub Issues or local `tasks.json`?
2. Should Claude create branches?
3. Should Claude open PRs?
4. Should Claude update issue labels automatically?
5. Should Claude post spec summaries as issue comments?

## Safe default

Do not write to GitHub automatically during initial onboarding. Generate local specs first.
