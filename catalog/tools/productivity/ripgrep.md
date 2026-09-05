# ripgrep

**Qué resuelve:** búsqueda rápida de texto, respetando `.gitignore` por defecto.

## Uso diario

```sh
rg 'TODO|FIXME'
rg -n 'OPENAI_API_KEY' --glob '!*.lock'
rg --files -g '*.md'
rg -C 3 'error' logs/
```

Evita buscar o imprimir secretos en salidas compartidas. Usa `--hidden` solo si entiendes qué ficheros incluye.

## Combinado con

Localiza manifiestos y revísalos con [Trivy](../security/trivy.md):

```sh
rg --files -g 'Dockerfile*' -g 'compose*.yml'
trivy config .
```

Fuente: [ripgrep](https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md).
