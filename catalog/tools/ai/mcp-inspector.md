# MCP Inspector

**Qué resuelve:** cliente web, CLI y TUI para probar servidores Model Context Protocol (MCP).

## Qué validar

Inspecciona primero el contrato: qué tools, resources y prompts anuncia el servidor; qué argumentos acepta; qué errores devuelve; y qué credenciales o red necesita. Después prueba casos de autorización denegada, timeout, entrada malformada y operaciones repetidas.

## Uso diario

```sh
mcp-inspector --help
mcp-inspector --cli --help
npx @modelcontextprotocol/inspector --tui
```

Inspecciona qué herramientas, recursos y prompts expone un servidor. Usa credenciales de prueba y no conectes servidores no confiables con acceso a secretos.

## Límite importante

El Inspector prueba el protocolo, no certifica la seguridad del servidor. La autorización, el filtrado de datos y la auditoría deben vivir en el servidor y en su infraestructura.

## Combinado con

Prueba un servidor local antes de configurarlo para [Codex](codex.md):

```sh
mcp-inspector --cli -- <comando-del-servidor>
codex
```

Fuente: [MCP Inspector](https://github.com/modelcontextprotocol/inspector).
