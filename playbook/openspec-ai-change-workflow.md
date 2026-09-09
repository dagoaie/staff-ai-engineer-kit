# Workflow OpenSpec para cambios AI de alto impacto

OpenSpec es el mecanismo de entrega, no un repositorio paralelo de estrategia. Su esquema por defecto produce `proposal`, `specs`, `design` y `tasks`; para cambios AI, esos artefactos deben enlazar a las decisiones y evidencia de esta carpeta.

## Cuándo activarlo

Úsalo si el cambio afecta a comportamiento de usuario, modelo, prompt de sistema, routing, RAG, herramienta MCP, datos, coste significativo, privacidad o superficie de seguridad. Para una corrección mecánica de bajo riesgo, no fuerces una especificación extensa.

## Secuencia

```text
investigación del comportamiento actual
  → /grill-with-docs y decisiones/ADR (si aplica)
    → openspec proposal
      → specs + design
        → tasks → implementación
          → evaluación, rollout y archivo
```

El *grill* precede al bundle OpenSpec definitivo para que el dominio, los ADRs y la documentación existente definan su alcance. Puede crearse un borrador temprano para ordenar la conversación, pero no se valida ni se usa como contrato de implementación hasta cerrar las decisiones relevantes.

## Contenido mínimo por artefacto

| OpenSpec | Debe incluir o enlazar |
| --- | --- |
| `proposal.md` | problema, usuario afectado, alcance, capacidades, owner y enlace a PRD/RFC/ADR |
| `specs/` | comportamiento observable, escenarios de error, autorización MCP y criterios de aceptación |
| `design.md` | HLD/LLD relevante, D2, modelo/routing, datos, límites, fallback, coste y telemetría |
| `tasks.md` | tareas verificables: evaluación, controles, migración, rollout, rollback y documentación |

## Gate antes de aplicar

- [ ] Scorecard de evaluación con baseline, segmentos y umbrales.
- [ ] Ficha de modelo actualizada; ficha de datos si hay corpus, fuentes o tratamiento nuevo.
- [ ] Presupuesto de coste/latencia y fallback definidos.
- [ ] Límites MCP revisados si se invocan herramientas.
- [ ] ADR enlazado si la decisión afecta a más de un cambio o es costosa de revertir.

## Implementación práctica

Inicializa OpenSpec en cada proyecto y conserva sus artefactos con el código:

```sh
openspec init
openspec status
openspec validate --help
```

Personaliza un esquema de OpenSpec en el propio proyecto solo después de que el equipo haya repetido este workflow y detecte campos que faltan de forma estable. Un schema local versionado es preferible a imponer una plantilla global que no encaje con todos los productos.
