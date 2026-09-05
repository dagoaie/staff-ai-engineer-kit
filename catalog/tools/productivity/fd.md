# fd

**Qué resuelve:** búsqueda de ficheros por nombre, más legible que `find` para casos habituales.

## Uso diario

```sh
fd 'Dockerfile'
fd -e yaml config/
fd -t d '^docs$'
fd -x bat {}
```

Comprueba el resultado antes de usar `-x` con comandos que modifiquen ficheros.

## Combinado con

Selecciona configuraciones para inspección interactiva con [fzf](fzf.md):

```sh
fd -e yaml | fzf --preview 'bat --color=always {}'
```

Fuente: [fd](https://github.com/sharkdp/fd).
