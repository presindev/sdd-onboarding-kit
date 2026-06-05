# Useful prompts for using the SDD harness

## Install SDD in a project

```text
Lee `sdd-onboarding-kit/instructions.md` y configura este repositorio para trabajar con Spec Driven Development. Hazme todas las preguntas necesarias antes de tomar decisiones específicas del proyecto.
```

## Start the next SDD task

```text
Usa el flujo SDD. Revisa `tasks.json`, selecciona la siguiente tarea pendiente marcada con `sdd: true`, genera la spec y detente para aprobación humana.
```

## Create a new task

```text
Crea una nueva tarea SDD para: <descripción>. Primero genera requirements/design/tasks y no implementes nada hasta que yo apruebe la spec.
```

## Approve a spec

```text
He revisado la spec de `<feature-slug>` y la apruebo. Cambia el estado a `human_approved` y prepara la implementación siguiendo `tasks.md`.
```

## Implement an approved spec

```text
Implementa la feature `<feature-slug>` siguiendo estrictamente la spec aprobada. Ejecuta tests y deja trazabilidad de lo que cambiaste.
```

## Review an implementation

```text
Usa el reviewer para validar la implementación de `<feature-slug>` contra requirements.md, design.md y tasks.md. Ejecuta tests y dime si se puede marcar como done.
```
