# Receta: entorno AI local

Objetivo: levantar un servicio local aislado, servir un modelo y comprobar que responde antes de evaluar.

## Pasos

Arranca la virtualización y el servicio del proyecto:

```sh
podman machine start
podman compose up -d
lazydocker
```

En otra terminal, abre LM Studio, selecciona un modelo apropiado para el hardware y arranca su servidor:

```sh
llmfit
lms server start
lms ps
http GET http://localhost:1234/v1/models
```

Observa recursos mientras haces una prueba:

```sh
lms chat
btop
```

## Guardrails

- Mantén el endpoint de LM Studio en localhost salvo que exista un diseño explícito de red y autenticación.
- No uses datasets con PII para validar un modelo descargado sin aprobación.
- Apaga servicios locales cuando termines: `podman compose down` y `lms server stop`.

Herramientas: [Podman](../tools/containers/podman.md), [LazyDocker](../tools/containers/lazydocker.md), [llmfit](../tools/local-llm/llmfit.md), [lms](../tools/local-llm/lms.md), [HTTPie](../tools/productivity/httpie.md), [btop](../tools/productivity/btop.md).
