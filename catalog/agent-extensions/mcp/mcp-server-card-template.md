# Ficha de servidor MCP: `<nombre>`

- **Origen / versión / owner:** `<…>`
- **Host compatible y transporte:** `<Codex/OpenCode; stdio/HTTP…>`
- **Ámbito:** personal | proyecto
- **Estado:** evaluación | aprobado | retirado

## Propósito y capacidad efectiva

| Herramienta expuesta | Lee / escribe / ejecuta | Datos o sistema afectado | Confirmación requerida |
| --- | --- | --- | --- |
| `<tool>` | `<…>` | `<…>` | `<…>` |

## Identidad y controles

- **Credencial y ubicación:** `<Keychain/SOPS/gestor aprobado; nunca el valor>`.
- **Permisos mínimos, timeout y rate limit:** `<…>`.
- **Datos que no puede exfiltrar:** `<…>`.
- **Auditoría y correlación:** `<…>`.
- **Desactivación / rollback:** `<comando o cambio de config>`.

## Validación

Prueba casos de autorización denegada, timeout, entrada malformada y acción mutable. Usa `mcp-inspector` antes de conectarlo a datos o sistemas reales y enlaza la evidencia a la MR/ADR correspondiente.
