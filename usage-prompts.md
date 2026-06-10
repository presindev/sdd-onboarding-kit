# Useful prompts for using the SDD harness

## Install SDD in a project

```text
Read `sdd-onboarding-kit/instructions.md` and configure this repository to use Spec Driven Development. Ask me all necessary questions before making project-specific decisions.
```

## Start the next SDD task

```text
Use the SDD workflow. Review `tasks.json`, select the next pending task marked with `sdd: true`, generate the spec and stop for human approval.
```

## Create a new task

```text
Create a new SDD task for: <description>. First generate requirements/design/tasks and do not implement anything until I approve the spec.
```

## Approve a spec

```text
I have reviewed the spec for `<feature-slug>` and I approve it. Change the status to `human_approved` and prepare the implementation following `tasks.html`.
```

## Implement an approved spec

```text
Implement feature `<feature-slug>` following the approved spec strictly. Run tests and leave traceability of what you changed.
```

## Review an implementation

```text
Use the reviewer to validate the implementation of `<feature-slug>` against requirements.html, design.html and tasks.html. Run tests and tell me if it can be marked as done.
```
