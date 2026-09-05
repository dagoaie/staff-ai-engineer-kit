# HTTPie

**Qué resuelve:** cliente HTTP legible para probar APIs y servicios locales.

## Uso diario

```sh
https GET https://example.com
http GET http://localhost:8080/health
http POST http://localhost:8080/v1/items name=demo
http --download GET <url>
```

Usa variables de entorno o un gestor de secretos para tokens; no los introduzcas en el historial.

## Combinado con

Prueba un endpoint de inferencia local de [LM Studio](../local-llm/lm-studio.md):

```sh
http GET http://localhost:1234/v1/models
```

Fuente: [HTTPie Documentation](https://httpie.io/docs/cli).
