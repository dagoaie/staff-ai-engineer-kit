# LM Studio

**Qué resuelve:** aplicación local para descargar, cargar y servir modelos en macOS; incluye el CLI `lms`.

## Uso diario

```sh
open -a "LM Studio"
lms --help
lms server start
lms ps
```

Descargar modelos puede consumir mucho disco y memoria. Verifica licencia, tamaño y procedencia antes de usarlos con datos de trabajo.

## Combinado con

Comprueba la API local con [HTTPie](../productivity/httpie.md):

```sh
lms server start
http GET http://localhost:1234/v1/models
```

Fuente: [LM Studio](https://lmstudio.ai/docs).
