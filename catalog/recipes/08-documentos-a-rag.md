# Receta: documentos a RAG evaluable

Objetivo: construir una cadena trazable desde una fuente documental hasta una respuesta RAG, con controles para saber si el problema procede de la ingesta, recuperación o generación.

## Definición de éxito

Antes de indexar, define fuentes autorizadas, clasificación de datos, métricas de recuperación, calidad de respuesta, casos de abstención y criterio de retirada de un documento. Una demo que responde una pregunta sencilla no demuestra que el corpus sea fiable.

## 1. Registrar la fuente

Copia la [ficha de datos](../../playbook/templates/data-card-template.md) al proyecto. Registra owner, licencia, clasificación, versión, propósito permitido, retención y procedimiento de eliminación. No indexas nada hasta que estos campos estén decididos.

## 2. Convertir una muestra con Docling

Instala Docling en el entorno del proyecto y convierte primero una muestra representativa:

```sh
uv add docling
uv run docling samples/ejemplo.pdf --to md --to json --output artifacts/docling
```

Inspecciona visualmente encabezados, tablas, orden de lectura, imágenes y OCR. Conserva checksums y metadatos de la fuente; evita versionar documentos restringidos o sus conversiones sin autorización.

## 3. Indexar con trazabilidad

Guarda por fragmento: identificador de fuente, versión, página/sección, estrategia de chunking, fecha de conversión y permisos de acceso. El índice debe permitir eliminar o reindexar una fuente sin reconstruir el mundo.

## 4. Evaluar cada capa

Mantén un corpus de preguntas que incluya respuestas correctas, ausencia de respuesta, contenido ambiguo y fallos pasados. Ejecuta la evaluación desde el entorno bloqueado:

```sh
uv add --dev deepeval
uv run deepeval test run evals/test_rag.py
promptfoo eval
```

DeepEval puede comprobar componentes y contexto recuperado; Promptfoo sirve como gate declarativo compartido. Ambos deben usar el mismo baseline y scorecard, no umbrales contradictorios.

## 5. Decidir y operar

Acepta un cambio solo si recuperación, groundedness/faithfulness, seguridad, p95 y coste cumplen los umbrales acordados. Enlaza el resultado al [scorecard](../../playbook/evaluation-scorecard-template.md), actualiza la ficha de modelo si cambia el routing y registra un ADR cuando el patrón de ingesta sea transversal.

Herramientas: [Docling](../tools/ai/docling.md), [DeepEval](../tools/ai/deepeval.md), [Promptfoo](../tools/ai/promptfoo.md), [uv](../tools/fundamentals/uv.md), [DuckDB](../tools/productivity/duckdb.md).
