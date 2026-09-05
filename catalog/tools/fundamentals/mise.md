# mise

**Qué resuelve:** fija versiones de runtimes y tareas por repositorio mediante `mise.toml`.

## Uso diario

```sh
mise use --local node@24
mise use --local python@3.13
mise install
mise current
```

Versiona `mise.toml`; no almacenes secretos allí.

## Combinado con

Combínalo con [direnv](direnv.md) para activar runtime y entorno al entrar en el proyecto:

```sh
mise trust
direnv allow
```

Fuente: [mise Documentation](https://mise.jdx.dev/).
