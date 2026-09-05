# Plantilla: política de model routing

La política debe ser comprensible sin conocer el código. No optimices solo por benchmark: declara calidad mínima, privacidad, coste y degradación.

## Alcance

- **Operaciones cubiertas:** `<clasificar, resumir, agente…>`
- **Datos prohibidos por proveedor:** `<clases de datos>`
- **Versión y owner:** `<fecha, equipo>`

## Reglas de selección

| Condición | Modelo/proveedor | Parámetros | Motivo | Fallback |
| --- | --- | --- | --- | --- |
| `<tarea simple>` | `<modelo rápido>` | `<temperature, max tokens>` | `<latencia/coste>` | `<ruta>` |
| `<alta complejidad>` | `<modelo capaz>` | `<…>` | `<calidad>` | `<ruta>` |
| `<datos restringidos>` | `<ruta aprobada>` | `<…>` | `<residencia/contrato>` | `<rechazar o revisión>` |

## Límites de cambio

Un cambio de modelo, parámetros, prompt de sistema, RAG o herramientas exige: ejecución del scorecard, comparación con baseline, revisión de presupuesto y actualización de este documento si cambia una regla. Define el kill switch y el criterio para volver al fallback.
