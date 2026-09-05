# bat

**Qué resuelve:** vista de ficheros con resaltado, números de línea y paginación.

## Uso diario

```sh
bat README.md
bat -n config.yaml
bat --diff before.yaml after.yaml
bat --list-themes
```

No uses `bat` para imprimir ficheros que puedan contener secretos en una sesión compartida.

## Combinado con

Previsualiza resultados de [fd](fd.md) mientras eliges uno:

```sh
fd -e md | fzf --preview 'bat --color=always {}'
```

Fuente: [bat](https://github.com/sharkdp/bat).
