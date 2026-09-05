# Promptfoo

**Qué resuelve:** evaluación y red teaming de aplicaciones LLM mediante configuraciones y casos de prueba versionables.

## Qué debe vivir en la suite

Versiona prompts, proveedores, dataset, aserciones y umbrales. Incluye casos normales, bordes del dominio, negativos, inyección de prompt y regresiones reales redactadas. Separa el baseline aceptado del candidato para poder explicar por qué se acepta un cambio.

## Uso diario

```sh
promptfoo init
promptfoo eval
promptfoo view
promptfoo redteam init --no-gui
```

Conserva corpus, umbrales y resultados junto al código. Trata prompts y outputs como datos potencialmente sensibles; usa credenciales de entorno, no ficheros versionados.

## Interpretar resultados

No decidas por una media aislada. Revisa fallos por caso, varianza, coste, latencia y los cambios que afectan a métricas de seguridad. Un resultado “verde” solo es válido si la suite representa el tráfico y políticas que importan.

## Combinado con

Evalúa un endpoint local de [LM Studio](../local-llm/lm-studio.md) y prueba su healthcheck con [HTTPie](../productivity/httpie.md):

```sh
http GET http://localhost:1234/v1/models
promptfoo eval
```

Fuente: [Promptfoo Documentation](https://www.promptfoo.dev/docs/).
