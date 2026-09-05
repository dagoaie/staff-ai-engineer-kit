# fzf

**Qué resuelve:** selector fuzzy interactivo para historial, rutas y resultados de comandos.

## Uso diario

```sh
fzf --version
git branch --all | fzf
rg --files | fzf
history | fzf
```

No automatices acciones destructivas a partir de una selección sin mostrar antes el objetivo.

## Combinado con

Abre un fichero encontrado por [ripgrep](ripgrep.md) en el editor configurado:

```sh
rg --files | fzf | xargs -r "$EDITOR"
```

Fuente: [fzf](https://junegunn.github.io/fzf/).
