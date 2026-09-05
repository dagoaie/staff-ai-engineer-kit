# Delta

**Qué resuelve:** visor de diffs de Git con sintaxis y navegación mejoradas.

## Uso diario

```sh
delta --version
git diff
git show <commit>
git log -p -1
```

Delta es un pager: no cambia el contenido de Git ni sustituye una revisión de seguridad.

## Combinado con

Úsalo para inspeccionar una corrección sugerida por Codex antes de añadirla:

```sh
git diff | delta
git add -p
```

Fuente: [Delta](https://dandavison.github.io/delta/).
