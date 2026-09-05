# glab-tui

**Qué resuelve:** interfaz terminal sobre GitLab CLI para navegar issues, merge requests y pipelines.

## Uso diario

```sh
glab-tui
glab-tui --help
```

Es una interfaz sobre la cuenta autenticada por `glab`; confirma las acciones mutables antes de ejecutarlas.

## Combinado con

Autentica primero con [glab](glab.md) y abre la interfaz desde el proyecto:

```sh
glab auth status
cd <repositorio>
glab-tui
```

Fuente: [glab-tui](https://github.com/ivangabriele/glab-tui).
