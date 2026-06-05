# Harness Engineering aplicado a SDD

Harness Engineering es la práctica de construir un arnés de trabajo alrededor de una IA para que siga un flujo concreto de manera repetible, auditable y segura.

SDD es el flujo. El harness es la infraestructura que fuerza o facilita ese flujo.

## Objetivo del harness

El objetivo no es que Claude Code “recuerde” una preferencia. El objetivo es que el repositorio contenga artefactos que guíen el trabajo de forma persistente:

- instrucciones del proyecto;
- subagentes especializados;
- skills reutilizables;
- hooks deterministas;
- memoria externa en archivos;
- plantillas de specs;
- scripts de validación;
- integración opcional con herramientas externas mediante MCP.

## Componentes del harness

### 1. Instrucciones persistentes

El proyecto debe tener un `CLAUDE.md` con reglas breves y específicas.

### 2. Subagentes

El flujo se divide en roles:

- `leader`: orquesta estados y decide qué fase toca;
- `spec-author`: genera requirements, design y tasks;
- `implementer`: implementa código contra la spec aprobada;
- `reviewer`: valida trazabilidad, tests y calidad.

### 3. Memoria externa

El contexto importante se guarda fuera del chat:

- `tasks.json`: estado de tareas;
- `specs/<feature>/`: specs versionables;
- `history.md`: historial de ejecución;
- `docs/architecture.md`: arquitectura;
- `docs/conventions.md`: convenciones.

### 4. Skill SDD

La skill contiene el procedimiento largo. Esto evita inflar `CLAUDE.md` con instrucciones que solo son necesarias durante tareas SDD.

### 5. Hooks

Los hooks pueden aplicar reglas deterministas, por ejemplo bloquear edición de código si no existe una spec aprobada.

Los hooks deben activarse solo tras aprobación del desarrollador.

### 6. MCPs

Los MCPs conectan Claude Code a herramientas externas: GitHub, Linear, Jira, documentación, memoria, bases de datos o sistemas internos.

Deben configurarse solo si el proyecto realmente los necesita.

## Principio de diseño

El harness debe ser:

- explícito;
- versionable;
- revisable;
- portable;
- configurable por proyecto;
- estricto donde haya riesgo;
- flexible donde el desarrollador necesite criterio.
