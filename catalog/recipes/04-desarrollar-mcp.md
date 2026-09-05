# Receta: desarrollar y validar MCP

Objetivo: publicar un servidor MCP con un contrato explícito y comprobarlo antes de concederlo a un agente.

## Diseño mínimo del contrato

Para cada tool documenta propósito, entradas validadas, salida acotada, permisos requeridos, timeout, idempotencia y efecto lateral. Diseña respuestas de error que permitan corregir la solicitud sin revelar datos internos. Si una tool escribe o llama a sistemas externos, exige confirmación o un modo de simulación cuando sea viable.

## Pasos

Especifica el cambio y deja claras entradas, salidas, autorización, timeout y efectos laterales:

```sh
openspec init
openspec new <servidor-mcp-o-cambio>
```

Inicia el servidor con datos de prueba e inspecciona su superficie:

```sh
mcp-inspector --cli -- <comando-del-servidor>
mcp-inspector --tui
```

Revisa que no haya secretos ni patrones inseguros y pruébalo desde el agente elegido:

```sh
gitleaks detect --source .
semgrep scan --config auto
codex
```

## Criterio de salida

El servidor está listo para integración cuando el Inspector puede enumerar y ejecutar casos válidos, las entradas inválidas fallan de forma segura, los permisos están restringidos y la suite automatizada cubre la superficie expuesta.

## Guardrails

- Cada herramienta MCP debe aplicar principio de mínimo privilegio y límites de tiempo/coste.
- Nunca pruebes contra datos reales ni inyectes claves en argumentos de proceso.
- Documenta y prueba operaciones mutables, paginación, errores y denegaciones de autorización.

Herramientas: [OpenSpec](../tools/ai/openspec.md), [MCP Inspector](../tools/ai/mcp-inspector.md), [Codex](../tools/ai/codex.md), [Gitleaks](../tools/security/gitleaks.md), [Semgrep](../tools/security/semgrep.md).
