# Staff AI operating system

Esta carpeta convierte las ideas de *The Staff Engineer's Path* en artefactos concretos para un Staff AI Engineer. El objetivo no es añadir procesos: es reducir ambigüedad, hacer visibles los trade-offs y permitir que otros equipos ejecuten con autonomía segura.

La práctica se apoya en cuatro movimientos: entender el sistema completo, escoger pocas apuestas de alto impacto, elevar la calidad de ejecución y aumentar la capacidad de los demás. En AI, eso significa que prompt, modelo, datos, herramientas, coste, seguridad y experiencia de usuario se gobiernan como un sistema único.

## Cómo usarlo

1. Empieza con el [plan de 90 días](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/playbook/90-day-plan.md) y crea un mapa para una capacidad AI real, no para toda la organización.
2. Copia las plantillas a `docs/` del repositorio o a la ubicación de decisión del equipo. Conserva la historia de decisiones cerca de la implementación.
3. Revisa scorecard, routing, presupuesto y telemetría en cada cambio que altere comportamiento, coste o superficie de datos.
4. Promueve los artefactos que demuestren utilidad; elimina los que no informen una decisión o una operación.

Antes de crear un documento, consulta la [matriz de decisión documental](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/playbook/documentation-decision-matrix.md). Su regla es proporcionalidad: un cambio pequeño no justifica una colección de plantillas; una apuesta transversal no debe depender de conocimiento implícito.

## Artefactos

- [Mapa de sistema](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/playbook/system-map-template.md): alcance, flujo de datos, propietarios y dependencias.
- [Política de model routing](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/playbook/model-routing-policy-template.md): cómo se elige modelo y cuándo se degrada.
- [Scorecard de evaluación](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/playbook/evaluation-scorecard-template.md): contrato de calidad antes de desplegar.
- [Límites de confianza MCP](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/playbook/mcp-trust-boundaries-template.md): capacidades, autorización y exfiltración.
- [Contrato de telemetría](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/playbook/telemetry-contract-template.md): señales operativas mínimas y privacidad.
- [Presupuesto de coste y latencia](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/playbook/cost-latency-budget-template.md): trade-offs explícitos por operación.
- [Checklist de producción](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/playbook/production-readiness-checklist.md): evidencia mínima antes de ampliar exposición.
- [ADR](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/playbook/adr-template.md): decisiones reversibles y sus condiciones de revisión.

## Documentación de producto y arquitectura

- [Technical Vision / Strategy](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/playbook/templates/technical-vision-strategy-template.md)
- [PRD](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/playbook/templates/prd-template.md)
- [RFC](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/playbook/templates/rfc-template.md)
- [HLD](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/playbook/templates/hld-template.md)
- [FDD](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/playbook/templates/fdd-template.md)
- [LLD](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/playbook/templates/lld-template.md)
- [Ficha de modelo](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/playbook/templates/model-card-template.md)
- [Ficha de datos](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/playbook/templates/data-card-template.md)
- [Fix brief](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/playbook/templates/fix-brief-template.md): puente versionado entre hallazgos aceptados de una review y `convoy --pipeline fixer`.
- [Runbook de cambio Jira](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/playbook/templates/jira-change-runbook-template.md): guía copy-paste desde el ticket hasta la PR/MR.
- [Workflow OpenSpec para cambios AI](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/playbook/openspec-ai-change-workflow.md)
- [Workflow de cambio Staff AI](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/playbook/staff-ai-change-workflow.md): fases para combinar especificación, skills, Convoy y gates humanos.

## Herramientas del bootstrap que lo soportan

- [D2](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/catalog/tools/productivity/d2.md) para mapas versionados.
- [DuckDB](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/catalog/tools/productivity/duckdb.md) para analizar resultados y telemetría redactada.
- [Promptfoo](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/catalog/tools/ai/promptfoo.md) para el scorecard de evaluación.
- [MCP Inspector](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/catalog/tools/ai/mcp-inspector.md), [SOPS](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/catalog/tools/security/sops.md) y [Semgrep](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/catalog/tools/security/semgrep.md) para controles.
- [Stern](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/catalog/tools/platform/stern.md), `kubectl` y OpenTelemetry para operar la capacidad desplegada.
- [adr-tools](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/catalog/tools/productivity/adr-tools.md), [markdownlint-cli2](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/catalog/tools/productivity/markdownlint-cli2.md) y [Lychee](https://github.com/dagocareer/staff-ai-engineer-kit/blob/main/catalog/tools/productivity/lychee.md) para decisiones duraderas y calidad documental.

No instala una plataforma de observabilidad ni OPA/Conftest todavía. Ambas decisiones requieren requisitos de retención, privacidad, presupuesto, identidad y adopción organizativa; adoptar el producto antes del contrato suele crear deuda de gobernanza.
