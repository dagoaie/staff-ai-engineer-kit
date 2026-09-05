# OpenSpec

**Qué resuelve:** CLI para especificar, planificar, validar y archivar cambios guiados por un agente de código.

## Cuándo usarlo

Úsalo para cambios que alteren comportamiento, contrato, arquitectura o riesgo operativo. Una corrección trivial puede documentarse en la issue/MR. El valor de OpenSpec está en hacer explícitos el problema, el alcance, las alternativas y la validación antes de tocar código.

## Uso diario

```sh
openspec init
openspec new <cambio>
openspec status
openspec validate --help
```

Inicialízalo por repositorio y revisa los artefactos generados antes de implementarlos. No trates la especificación como aprobación automática de cambios de producción.

El flujo estándar separa el porqué (`proposal`), el comportamiento (`specs`), el diseño (`design`) y la ejecución (`tasks`). Es una división muy útil para evitar que un agente convierta una suposición de diseño en un requisito de producto.

## Buen criterio de aceptación

Escribe criterios que puedan comprobarse con un test, comando, métrica o revisión concreta. “Funciona bien” no es verificable; “la evaluación X no baja de Y y el p95 queda bajo Z” sí lo es.

## Combinado con

Convierte una especificación aprobada en contexto para [Codex](codex.md):

```sh
openspec new <cambio>
codex
```

Para cambios AI que alteran modelo, datos, routing, herramientas o riesgo, sigue el [workflow OpenSpec AI](../../../playbook/openspec-ai-change-workflow.md). Enlaza el scorecard de [Promptfoo](promptfoo.md), la ficha de modelo/datos y cualquier ADR relevante antes de aplicar tareas.

Fuente: [OpenSpec Documentation](https://openspec.dev/docs/).
