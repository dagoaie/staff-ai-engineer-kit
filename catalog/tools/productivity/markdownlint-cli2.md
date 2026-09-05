# markdownlint-cli2

`markdownlint-cli2` aplica reglas de formato a Markdown. Es una protección ligera para que PRDs, RFCs y guías se puedan revisar sin discusiones repetidas sobre estilo.

## Uso diario

Comprueba los documentos del repositorio:

```sh
markdownlint-cli2 "README.md" "catalog/**/*.md" "playbook/**/*.md"
```

Versiona una configuración cuando el equipo necesite excepciones justificadas. No uses la herramienta para imponer una voz editorial; úsala para detectar estructura inconsistente, encabezados rotos o bloques de código mal formados.

## Combinado con

- [Lychee](lychee.md): ejecuta ambas comprobaciones en CI para que la documentación publicada no tenga enlaces rotos.
- [just](just.md): expón una receta `docs-check` que ejecute los dos comandos.
- [OpenSpec](../ai/openspec.md): valida los artefactos del cambio antes de pedir revisión.

## Referencia

- [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2)
