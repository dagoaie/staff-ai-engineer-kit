# btop

**Qué resuelve:** monitor interactivo de CPU, memoria, procesos y disco.

## Uso diario

```sh
btop
btop --version
```

Úsalo para diagnosticar carga local; no sustituye métricas, trazas ni alertas de producción.

## Combinado con

Mientras ejecutas inferencia con [lms](../local-llm/lms.md), observa consumo de memoria y CPU:

```sh
lms ps
btop
```

Fuente: [btop](https://github.com/aristocratos/btop).
