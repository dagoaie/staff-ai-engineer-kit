# Plan de 90 días para una práctica Staff AI

Este plan es una secuencia de aprendizaje y entrega. Ajusta el ritmo al contexto, pero no saltes de una demo directamente a una plataforma transversal.

## Días 0–30: mapa y apuesta

- Elige una capacidad AI con usuarios y riesgo reales.
- Completa el [mapa de sistema](system-map-template.md): datos, modelos, herramientas, dependencias, propietarios y puntos de fallo.
- Publica una primera [política de routing](model-routing-policy-template.md) y un [presupuesto](cost-latency-budget-template.md), aunque tengan incógnitas explícitas.
- Define el baseline del [scorecard](evaluation-scorecard-template.md) con casos normales, fallos y adversariales.

**Salida:** una decisión de alcance que el equipo puede cuestionar y una métrica base que permite comprobar mejora.

## Días 31–60: convertir calidad en una puerta de entrega

- Implementa un vertical slice: cambio de prompt/modelo/RAG/herramienta que corra evaluaciones reproducibles en CI.
- Instrumenta el [contrato de telemetría](telemetry-contract-template.md), empezando por latencia, tokens, coste, resultado y fallos; redacción primero.
- Define límites MCP para cada herramienta conectada y valida el servidor con MCP Inspector.
- Registra decisiones que afecten a varios equipos usando el [ADR](adr-template.md).

**Salida:** un cambio que no depende de intuición para demostrar calidad, coste y comportamiento operativo.

## Días 61–90: escala por influencia

- Reutiliza plantillas y gates en un segundo equipo o flujo, sin forzar una reescritura de su stack.
- Revisa el scorecard con producto, seguridad y operación: elimina métricas vanidosas y añade decisiones que realmente se toman.
- Establece una cadencia ligera: revisión mensual de presupuesto/routing y retrospectiva de incidentes o regresiones.
- Documenta los huecos que sí justifican plataforma compartida (por ejemplo, trazas centralizadas o políticas ejecutables) con evidencia de repetición.

**Salida:** estándares adoptados porque reducen trabajo y riesgo, no porque un Staff Engineer los haya impuesto.
