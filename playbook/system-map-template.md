# Plantilla: mapa de sistema AI

> Usa [D2](../catalog/tools/productivity/d2.md) para el diagrama; este documento explica las decisiones que el diagrama no contiene.

## Propósito y resultado de usuario

- **Capacidad:** `<nombre>`
- **Usuario / decisión que habilita:** `<quién y qué cambia>`
- **Owner de negocio:** `<equipo/persona>`
- **Owner técnico:** `<equipo/persona>`
- **SLO o expectativa:** `<calidad, disponibilidad, latencia>`

## Flujo y fronteras

| Paso | Componente | Datos de entrada | Salida | Riesgo / control | Owner |
| --- | --- | --- | --- | --- | --- |
| 1 | `<API>` | `<clasificación>` | `<petición>` | `<autorización>` | `<equipo>` |
| 2 | `<router/modelo/herramienta>` | `<…>` | `<…>` | `<redacción, timeout>` | `<equipo>` |

Indica explícitamente qué dato no debe cruzar a cada proveedor o herramienta y qué ocurre ante timeout, cuota agotada o resultado inseguro.

## Dependencias y decisiones abiertas

- **Dependencias externas:** `<modelo, índice, API, clúster>`.
- **Puntos únicos de fallo:** `<…>`.
- **Suposiciones por validar:** `<…>`.
- **Decisiones enlazadas:** `<ADR, issue o spec>`.
