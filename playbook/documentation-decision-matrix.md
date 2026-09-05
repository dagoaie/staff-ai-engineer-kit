# Matriz de decisión documental

La documentación es un mecanismo de alineamiento y de memoria institucional. Selecciona el mínimo conjunto que permita tomar una decisión, ejecutar el cambio y operar sus consecuencias. Crear todos los documentos para todo cambio es burocracia; no crear ninguno para cambios transversales es deuda de coordinación.

## Qué documento usar

| Artefacto | Pregunta que responde | Cuándo es obligatorio | Owner inicial | Caducidad / revisión |
| --- | --- | --- | --- | --- |
| [Technical Vision / Strategy](templates/technical-vision-strategy-template.md) | ¿Qué apuestas y capacidades importan? | prioridades multi-equipo | Staff / liderazgo técnico | trimestral o semestral |
| [PRD](templates/prd-template.md) | ¿Qué resultado de usuario/negocio buscamos? | nueva iniciativa de producto | Product + engineering | al cambiar objetivo |
| [RFC](templates/rfc-template.md) | ¿Qué propuesta transversal elegimos? | varias alternativas o equipos afectados | proponente | al decidir |
| [HLD](templates/hld-template.md) | ¿Cuál es la forma y frontera del sistema? | cambio arquitectónico o nueva capacidad | tech lead / Staff | al cambiar arquitectura |
| [FDD](templates/fdd-template.md) | ¿Qué comportamiento verá el usuario? | comportamiento, API o contrato cambia | equipo responsable | por release/cambio |
| [LLD](templates/lld-template.md) | ¿Cómo se implementan los detalles críticos? | complejidad, concurrencia, migración o riesgo | implementador | por cambio |
| [ADR](adr-template.md) | ¿Qué decisión duradera tomamos y por qué? | trade-off difícil de revertir | quien decide | ante disparador explícito |
| [Ficha de modelo](templates/model-card-template.md) | ¿Qué modelo se usa y con qué límites? | modelo, prompt de sistema o routing cambia | AI owner | por versión |
| [Ficha de datos](templates/data-card-template.md) | ¿Qué datos entran y qué riesgos tienen? | dataset, corpus RAG o fuente cambia | data owner | por versión/fuente |

## Rutas proporcionales

| Tipo de cambio | Artefactos mínimos |
| --- | --- |
| Corrección local, sin contrato ni riesgo | Issue/MR; OpenSpec solo si aclara comportamiento |
| Nueva funcionalidad acotada | PRD ligero + FDD + OpenSpec |
| Cambio de componente, datos o integración | FDD + LLD + HLD si altera fronteras |
| Decisión transversal o difícil de revertir | RFC + ADR + HLD |
| Cambio AI de alto impacto | FDD + ficha de modelo + ficha de datos si aplica + scorecard + presupuesto + OpenSpec |
| Nueva apuesta multi-equipo | Strategy + PRD + RFC + HLD; después, cambios OpenSpec por vertical slice |

## Regla de trazabilidad

Todo documento debe enlazar hacia arriba a la decisión o necesidad que lo motiva y hacia abajo a la evidencia que lo valida: issue/PRD → RFC/ADR → diseño y OpenSpec → código, evaluación, despliegue y telemetría. Si un artefacto no informa una decisión, una implementación o una operación, archívalo o elimínalo.

## Calidad documental en CI

Para repositorios que documenten de forma activa:

```sh
markdownlint-cli2 "README.md" "catalog/**/*.md" "playbook/**/*.md"
lychee README.md 'catalog/**/*.md' 'playbook/**/*.md'
```

Añade ambos a una receta `just docs-check` o al pipeline. Las excepciones de enlaces externos deben ser específicas y revisables.
