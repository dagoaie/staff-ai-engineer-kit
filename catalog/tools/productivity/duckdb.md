# DuckDB

DuckDB es una base de datos analítica embebida con un CLI SQL. Sirve para explorar resultados de evaluaciones, trazas exportadas, costes o inventarios de forma local, sin subir datos a un SaaS ni montar una base de datos.

## Uso diario

Abrir un fichero de resultados JSON y seleccionar columnas útiles:

```sh
duckdb -c "
  SELECT *
  FROM read_json_auto('artifacts/eval-results.json')
  LIMIT 20;
"
```

Comparar agregados de dos ejecuciones que hayas normalizado a Parquet:

```sh
duckdb -c "
  SELECT model, avg(latency_ms) AS latency_ms, avg(score) AS score
  FROM read_parquet('artifacts/*.parquet')
  GROUP BY model
  ORDER BY score DESC;
"
```

No exportes prompts, respuestas ni trazas con PII sin redactar. Guarda artefactos locales bajo `artifacts/` e ignóralos en Git cuando contengan datos sensibles.

## Combinado con

- [Promptfoo](../ai/promptfoo.md): convierte una salida de evaluación a JSON/CSV y úsala para detectar regresiones por modelo, caso o versión de prompt.
- [jq](jq.md): inspecciona la forma del JSON antes de crear la consulta SQL.
- [D2](d2.md): plasma en un diagrama la decisión tomada a partir de los datos, no solo la métrica final.

## Referencias

- [DuckDB CLI](https://duckdb.org/docs/stable/clients/cli/overview.html)
- [Lectura de JSON](https://duckdb.org/docs/stable/data/json/overview.html)
