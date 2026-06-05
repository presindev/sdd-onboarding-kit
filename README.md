# SDD Onboarding Kit for Claude Code

Este kit instala un **harness de Spec Driven Development (SDD)** en un repositorio que vaya a trabajarse con Claude Code.

No es una configuración global de usuario. Es una plantilla reusable para configurar cada proyecto concreto. El resultado final del onboarding debe ser una configuración dentro del repositorio destino: `CLAUDE.md`, `.claude/agents/`, `.claude/skills/`, `.claude/settings.json`, `specs/`, `tasks.json`, `history.md` y scripts de validación.

## Cuándo usar este kit

Úsalo cuando quieras que Claude Code trabaje así:

1. El desarrollador define o selecciona una tarea.
2. Claude crea una especificación antes de tocar código.
3. El humano revisa y aprueba la especificación.
4. Claude implementa solo contra la spec aprobada.
5. Claude ejecuta tests y validaciones.
6. Claude revisa trazabilidad entre requisitos, diseño, tareas, código y tests.
7. La tarea se marca como completada o se devuelve a corrección.

## Cómo usarlo desde Claude Code

Copia o añade esta carpeta al proyecto donde quieras instalar SDD, por ejemplo:

```text
mi-proyecto/
└── sdd-onboarding-kit/
```

Después abre Claude Code en `mi-proyecto/` y dile:

```text
Lee `sdd-onboarding-kit/instructions.md` y configura este repositorio para trabajar con SDD. Hazme todas las preguntas necesarias antes de tomar decisiones específicas del proyecto.
```

## Archivos principales

- `instructions.md`: procedimiento que Claude Code debe seguir para instalar el harness.
- `questions.md`: decisiones que Claude debe preguntar al desarrollador.
- `reference/`: teoría y fundamentos del flujo SDD.
- `agents/`: plantillas de subagentes para copiar a `.claude/agents/`.
- `skills/sdd-workflow/`: skill reusable del flujo SDD.
- `hooks/`: políticas, snippets y ejemplos de hooks.
- `mcps/`: criterios para decidir si configurar MCPs.
- `templates/`: archivos que Claude adaptará al repositorio destino.
- `scripts/`: scripts base para validar estructura, entorno y tests.
- `output-project-structure.md`: estructura final esperada tras el onboarding.

## Principio central

El onboarding debe producir una configuración específica del proyecto. No debe copiar reglas genéricas sin adaptarlas. Si falta una decisión, Claude Code debe preguntar.

## Fuentes conceptuales

Este kit está basado en una transcripción sobre un setup de Claude Code para Spec Driven Development y en la documentación pública de Claude Code sobre `CLAUDE.md`, subagentes, skills, hooks y MCPs.

## Functional document intake

The kit supports generating SDD specs from functional documents.

Use this when starting from:

- PRDs;
- product briefs;
- tickets;
- user stories;
- informal feature descriptions.

Claude Code will convert the source document into:

- requirements;
- design;
- tasks;
- assumptions;
- open questions;
- acceptance tests.

It will not implement until the spec is approved.