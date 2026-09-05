# uv

**Qué resuelve:** gestión rápida y aislada de Python, dependencias y CLIs Python.

## Uso diario

```sh
uv python install 3.13
uv init
uv add <paquete>
uv run pytest
uv tool install <cli>
```

`uv tool install` aísla CLIs globales; no modifiques sus entornos con `pip` directamente.

## Combinado con

Ejecuta una utilidad puntual sin contaminar el proyecto:

```sh
uvx ruff check .
uv tool upgrade llmfit
```

Fuente: [uv Documentation](https://docs.astral.sh/uv/).
