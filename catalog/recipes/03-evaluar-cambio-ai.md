# Receta: evaluar un cambio AI

Objetivo: comparar de forma repetible un cambio de prompt, modelo, RAG o herramienta antes de integrarlo.

## Definición de éxito

Antes de ejecutar, declara qué hipótesis se prueba, cuál es el baseline, qué regresiones son inaceptables y quién decide ante resultados mixtos. Como mínimo mide calidad por caso, tasa de fallo, p95 de latencia y coste por solicitud; añade seguridad y fidelidad de recuperación cuando apliquen.

## Pasos

Inicializa la suite y guarda casos y aserciones en el repositorio:

```sh
promptfoo init
git add promptfooconfig.yaml
```

Verifica el endpoint que ejecutará la evaluación y lanza el conjunto:

```sh
http GET http://localhost:1234/v1/models
promptfoo eval
promptfoo view
```

Para cambios de superficie de ataque, añade red teaming y conserva el reporte:

```sh
promptfoo redteam init --no-gui
promptfoo redteam run
```

## Decisión

Acepta el cambio solo si cumple los umbrales acordados y no introduce regresiones críticas. Si mejora una métrica y empeora otra, registra el trade-off en la MR con el enlace al resultado; no “optimices” la suite eliminando casos que fallan.

## Guardrails

- Define un baseline, métricas y umbrales de aceptación antes de mirar los resultados.
- Separa datos de evaluación sintéticos de datos de producción; redacta entradas y salidas sensibles.
- Ejecuta la misma suite para el baseline y el candidato, con configuración de proveedor trazable.
- Conserva el commit, modelo, prompt, fecha y configuración que generaron cada resultado aceptado.

Herramientas: [Promptfoo](../tools/ai/promptfoo.md), [LM Studio](../tools/local-llm/lm-studio.md), [HTTPie](../tools/productivity/httpie.md), [Git](../tools/productivity/git.md).
