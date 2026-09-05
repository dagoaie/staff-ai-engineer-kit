# Docling

Docling convierte PDF, Office, HTML, imágenes y otros formatos a una representación estructurada, Markdown o JSON. Es una pieza de ingesta para RAG y extracción documental; no garantiza que el contenido convertido sea correcto para tu dominio.

## Instalación por proyecto

Docling depende de PyTorch y puede requerir OCR o configuración distinta según hardware y formato. Decláralo en el proyecto que procesa el documento:

```sh
uv add docling
uv run docling input/contrato.pdf --to md --to json --output artifacts/docling
```

Versiona el código de conversión y la configuración, no documentos sensibles ni artefactos generados que no estén autorizados para Git.

## Uso diario

Convierte una muestra representativa antes de procesar un corpus completo:

```sh
uv run docling samples/ejemplo.pdf --to md --to json --output artifacts/docling
glow artifacts/docling/ejemplo.md
```

Comprueba manualmente títulos, tablas, orden de lectura, idioma, pies de página y contenido OCR. Esos defectos se propagan al chunking y pueden parecer alucinaciones del modelo más tarde.

## Combinado con

- [Ficha de datos](../../../playbook/templates/data-card-template.md): registra origen, clasificación, licencia, transformación, versión y retención del corpus.
- [DeepEval](deepeval.md) y [Promptfoo](promptfoo.md): evalúa recuperación y respuesta usando documentos convertidos, casos difíciles y fallos históricos.
- [DuckDB](../productivity/duckdb.md): inspecciona métricas y metadatos exportados de la ingesta sin enviar datos a un tercero.

## Referencias

- [Instalación de Docling](https://docling-project.github.io/docling/getting_started/installation/)
- [CLI de Docling](https://docling-project.github.io/docling/reference/cli/)
