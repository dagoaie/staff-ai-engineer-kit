# Extensiones de agente

Las extensiones amplían agentes de código, pero no todas tienen el mismo perfil de riesgo.

| Tipo | Qué aporta | Dónde vive | Control principal |
| --- | --- | --- | --- |
| Skill personal | instrucciones y workflows para tu agente | configuración local del host | origen, contenido y actualización |
| Skill de proyecto | convenciones reutilizables del equipo | versionada con el repositorio | revisión por MR |
| MCP personal | acceso a datos o acciones personales | configuración local | secretos y mínimo privilegio |
| MCP de proyecto | capacidades compartidas de un producto/equipo | configuración por proyecto | identidad, auditoría y límites |

Una skill escala criterio; un MCP escala capacidad y superficie de riesgo. Nunca instales una extensión por popularidad: registra el problema que resuelve, host compatible, owner y cómo se desactiva.

## Registros

- [Skills](skills/skills-for-real-engineers.md): colección instalada de forma interactiva por el bootstrap.
- [Plantilla de ficha de skill](skills/skill-card-template.md)
- [Plantilla de ficha MCP](mcp/mcp-server-card-template.md)

Cuando adoptes un MCP, completa la ficha y compárala con los [límites de confianza MCP](../../playbook/mcp-trust-boundaries-template.md). Valida el servidor con [MCP Inspector](../tools/ai/mcp-inspector.md) antes de concederle datos o acciones reales.
