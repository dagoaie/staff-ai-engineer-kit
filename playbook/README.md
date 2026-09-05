# Staff AI operating system

Esta carpeta convierte las ideas de *The Staff Engineer's Path* en artefactos concretos para un Staff AI Engineer. El objetivo no es añadir procesos: es reducir ambigüedad, hacer visibles los trade-offs y permitir que otros equipos ejecuten con autonomía segura.

La práctica se apoya en cuatro movimientos: entender el sistema completo, escoger pocas apuestas de alto impacto, elevar la calidad de ejecución y aumentar la capacidad de los demás. En AI, eso significa que prompt, modelo, datos, herramientas, coste, seguridad y experiencia de usuario se gobiernan como un sistema único.

## Cómo usarlo

1. Empieza con el [plan de 90 días](90-day-plan.md) y crea un mapa para una capacidad AI real, no para toda la organización.
2. Copia las plantillas a `docs/` del repositorio o a la ubicación de decisión del equipo. Conserva la historia de decisiones cerca de la implementación.
3. Revisa scorecard, routing, presupuesto y telemetría en cada cambio que altere comportamiento, coste o superficie de datos.
4. Promueve los artefactos que demuestren utilidad; elimina los que no informen una decisión o una operación.

Antes de crear un documento, consulta la [matriz de decisión documental](documentation-decision-matrix.md). Su regla es proporcionalidad: un cambio pequeño no justifica una colección de plantillas; una apuesta transversal no debe depender de conocimiento implícito.

## Artefactos

- [Mapa de sistema](system-map-template.md): alcance, flujo de datos, propietarios y dependencias.
- [Política de model routing](model-routing-policy-template.md): cómo se elige modelo y cuándo se degrada.
- [Scorecard de evaluación](evaluation-scorecard-template.md): contrato de calidad antes de desplegar.
- [Límites de confianza MCP](mcp-trust-boundaries-template.md): capacidades, autorización y exfiltración.
- [Contrato de telemetría](telemetry-contract-template.md): señales operativas mínimas y privacidad.
- [Presupuesto de coste y latencia](cost-latency-budget-template.md): trade-offs explícitos por operación.
- [Checklist de producción](production-readiness-checklist.md): evidencia mínima antes de ampliar exposición.
- [ADR](adr-template.md): decisiones reversibles y sus condiciones de revisión.

## Documentación de producto y arquitectura

- [Technical Vision / Strategy](templates/technical-vision-strategy-template.md)
- [PRD](templates/prd-template.md)
- [RFC](templates/rfc-template.md)
- [HLD](templates/hld-template.md)
- [FDD](templates/fdd-template.md)
- [LLD](templates/lld-template.md)
- [Ficha de modelo](templates/model-card-template.md)
- [Ficha de datos](templates/data-card-template.md)
- [Workflow OpenSpec para cambios AI](openspec-ai-change-workflow.md)

## Herramientas del bootstrap que lo soportan

- [D2](../catalog/tools/productivity/d2.md) para mapas versionados.
- [DuckDB](../catalog/tools/productivity/duckdb.md) para analizar resultados y telemetría redactada.
- [Promptfoo](../catalog/tools/ai/promptfoo.md) para el scorecard de evaluación.
- [MCP Inspector](../catalog/tools/ai/mcp-inspector.md), [SOPS](../catalog/tools/security/sops.md) y [Semgrep](../catalog/tools/security/semgrep.md) para controles.
- [Stern](../catalog/tools/platform/stern.md), `kubectl` y OpenTelemetry para operar la capacidad desplegada.
- [adr-tools](../catalog/tools/productivity/adr-tools.md), [markdownlint-cli2](../catalog/tools/productivity/markdownlint-cli2.md) y [Lychee](../catalog/tools/productivity/lychee.md) para decisiones duraderas y calidad documental.

No instala una plataforma de observabilidad ni OPA/Conftest todavía. Ambas decisiones requieren requisitos de retención, privacidad, presupuesto, identidad y adopción organizativa; adoptar el producto antes del contrato suele crear deuda de gobernanza.
