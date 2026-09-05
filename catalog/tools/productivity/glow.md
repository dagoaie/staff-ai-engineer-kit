# Glow

**Qué resuelve:** lector y navegador de Markdown para terminal, pensado para documentación más larga o enlazada. Complementa a `bat`: Glow renderiza y pagina; `bat` muestra rápidamente un fichero.

## Uso diario

```sh
glow README.md
glow catalog/README.md
glow catalog/tools/ai/codex.md
glow -w 100 catalog/recipes/03-evaluar-cambio-ai.md
```

Dentro del visor, usa `/` para buscar, `?` para ver atajos, `e` para abrir el editor y `q` para salir. Sin argumentos, Glow descubre Markdown bajo el directorio actual o repositorio Git.

## Combinado con

Encuentra una guía con [fd](fd.md) y léela de forma interactiva:

```sh
fd -e md docs | fzf | xargs -r glow
```

Para comprobar un fragmento breve o comparar ficheros, usa [bat](bat.md) en lugar de abrir una sesión completa de Glow.

Fuente: [Glow](https://github.com/charmbracelet/glow).
