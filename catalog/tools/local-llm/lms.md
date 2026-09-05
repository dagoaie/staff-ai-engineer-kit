# `lms`

**Qué resuelve:** CLI incluida con LM Studio para controlar modelos, runtime, servidor e inferencia local.

## Uso diario

```sh
lms ls
lms ps
lms server start
lms server stop
lms chat
```

Abre LM Studio al menos una vez tras la instalación. No expongas el servidor local en una red no confiable sin autenticación y controles explícitos.

## Combinado con

Elige modelos razonables para el hardware con [llmfit](llmfit.md) antes de cargarlos:

```sh
llmfit
lms ls
```

Fuente: [lms CLI](https://lmstudio.ai/docs/cli).
