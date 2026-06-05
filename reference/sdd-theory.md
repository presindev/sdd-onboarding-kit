# Spec Driven Development: teoría operativa

Spec Driven Development, o SDD, es un flujo de trabajo en el que la especificación ocupa el centro del proceso de desarrollo.

La tesis práctica es simple: antes de pedirle a una IA que escriba código, se debe definir de forma suficientemente precisa qué debe construir, cómo debe comportarse el sistema y cómo se validará el resultado.

## Qué es una spec

Una spec es una representación explícita del software que se quiere implementar. Puede contener:

- requisitos funcionales;
- requisitos no funcionales;
- historias de usuario;
- criterios de aceptación;
- escenarios de error;
- diseño técnico;
- cambios de archivos;
- tareas implementables;
- estrategia de testing;
- restricciones de arquitectura.

En este kit, una spec de feature se divide por defecto en cuatro documentos:

```text
specs/<feature-slug>/
├── requirements.md
├── design.md
├── tasks.md
└── review.md
```

## La spec como fuente de verdad

En SDD, la IA no implementa directamente desde una conversación vaga. Implementa contra documentos concretos.

Esto reduce tres problemas habituales del desarrollo con IA:

1. pérdida de contexto en conversaciones largas;
2. ambigüedad en instrucciones naturales;
3. dificultad para comprobar si el código generado corresponde realmente a lo solicitado.

## Flujo general

El flujo base es:

```text
especificar → aprobar → implementar → validar → cerrar o iterar
```

Traducido a estados de trabajo:

```text
pending → spec_draft → spec_ready → human_approved → in_progress → review → done
```

## Papel del humano

Este kit no está diseñado para eliminar al desarrollador del proceso. Está diseñado para que el desarrollador conserve control sobre:

- intención del producto;
- arquitectura;
- criterios de aceptación;
- validación de tests;
- decisiones de seguridad;
- decisión final de marcar una tarea como completada.

La IA acelera el proceso, pero el criterio técnico sigue siendo responsabilidad del equipo.

## Relación con TDD

SDD no sustituye necesariamente a TDD. Puede incluir TDD.

Una spec bien escrita debe facilitar la generación de tests. Si se usa una notación como EARS o Given/When/Then, cada requisito puede transformarse en uno o varios tests.

## Cuándo usar SDD

Usa SDD para:

- features con varios pasos;
- cambios que afecten a arquitectura;
- cambios con impacto en APIs;
- lógica de negocio importante;
- cambios donde la trazabilidad sea valiosa;
- tareas que requieran tests nuevos o modificados.

No siempre hace falta SDD para:

- typos;
- cambios cosméticos triviales;
- renombrados locales;
- documentación menor;
- pequeños fixes obvios.

El proyecto debe definir explícitamente qué tareas pueden saltarse SDD.
