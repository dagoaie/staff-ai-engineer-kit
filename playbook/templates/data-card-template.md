# Ficha de datos: `<dataset, corpus o fuente>`

## Identidad

- **Owner / sistema origen:** `<…>`
- **Versión, fecha y cobertura:** `<…>`
- **Finalidad permitida:** `<…>`
- **Base de acceso / clasificación:** `<público, interno, PII…>`

## Ciclo de vida

| Fase | Proceso | Control |
| --- | --- | --- |
| Obtención | `<fuente>` | `<consentimiento/licencia>` |
| Transformación | `<Docling, chunking, limpieza, labels>` | `<redacción/validación>` |
| Uso | `<RAG, entrenamiento, evaluación>` | `<autorización>` |
| Retención / borrado | `<plazo>` | `<proceso verificable>` |

## Calidad, riesgo y revisión

Documenta cobertura, actualidad, sesgos, duplicados, datos sensibles, procedencia y limitaciones. Si usas Docling, registra versión, opciones de OCR/transformación y una muestra de validación humana. Enlaza evaluaciones de recuperación/calidad, la política de modelo que consume los datos y el procedimiento para corregir o retirar una fuente.
