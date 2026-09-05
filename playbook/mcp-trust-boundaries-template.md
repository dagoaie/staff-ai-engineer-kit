# Plantilla: límites de confianza MCP

Una herramienta MCP convierte lenguaje en una acción. Documenta la capacidad efectiva, no solo el nombre del servidor.

| Herramienta | Acción y datos | Identidad/autorización | Límites | Confirmación | Auditoría |
| --- | --- | --- | --- | --- | --- |
| `<tool>` | `<lectura/escritura/external>` | `<scopes>` | `<timeout, rate, tamaño>` | `<humana o política>` | `<trace/audit id>` |

## Reglas

- **Mínimo privilegio:** la identidad del servidor no hereda permisos del usuario sin necesidad.
- **Exfiltración:** enumera destinos externos y campos que deben redactarse o bloquearse.
- **Acciones mutables:** define confirmación, idempotencia, rollback y entorno permitido.
- **Fallo seguro:** timeout, salida malformada o autorización ausente no deben desencadenar reintentos peligrosos.
- **Prueba:** valida contratos y errores con [MCP Inspector](../catalog/tools/ai/mcp-inspector.md) antes de exponer la herramienta a usuarios.
