# Plantilla: scorecard de evaluación

El scorecard es el contrato de comportamiento de una capacidad, no un ranking de modelos. Mantén los casos versionados y separa conjuntos de desarrollo, regresión y holdout.

## Decisión que informa

- **Cambio evaluado:** `<PR, modelo, prompt, RAG, herramienta>`
- **Baseline:** `<commit/ejecución>`
- **Aprobador:** `<rol/equipo>`
- **Riesgo de falso positivo/negativo:** `<impacto>`

## Métricas y umbrales

| Dimensión | Métrica | Baseline | Umbral | Segmentos | Evidencia |
| --- | --- | ---: | ---: | --- | --- |
| Calidad | `<exactitud/judge/rúbrica>` | `<x>` | `>= <x>` | `<idioma, caso>` | `<artifact>` |
| Seguridad | `<tasa de rechazo/fuga>` | `<x>` | `<= <x>` | `<ataques>` | `<artifact>` |
| Latencia | `p95` | `<ms>` | `<= <ms>` | `<ruta>` | `<traza>` |
| Coste | `coste por éxito` | `<€>` | `<= <€>` | `<modelo>` | `<consulta>` |

## Casos obligatorios

- Casos representativos de usuario.
- Regresiones de incidentes previos.
- Entradas inválidas, ambiguas y adversariales.
- Casos de herramientas MCP denegadas, timeout y respuesta parcial.

Registra la razón de una excepción; no rebajes el umbral para convertir una regresión en verde.
