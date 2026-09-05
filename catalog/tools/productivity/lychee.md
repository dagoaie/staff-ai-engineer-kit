# Lychee

Lychee comprueba enlaces en Markdown, HTML y otros formatos. Evita que la documentación pierda confianza lentamente por referencias locales o externas que dejan de funcionar.

## Uso diario

Valida la documentación de un repositorio:

```sh
lychee README.md 'catalog/**/*.md' 'playbook/**/*.md'
```

Los servicios externos pueden limitar solicitudes o exigir autenticación. Configura exclusiones explícitas y con motivo; no silencies todos los fallos de red porque entonces el check deja de ser útil.

## Combinado con

- [markdownlint-cli2](markdownlint-cli2.md): calidad estructural y enlaces se revisan juntos antes de una MR.
- [just](just.md): crea una receta de lectura que se ejecute localmente y en CI.
- [Glow](glow.md): inspecciona el documento renderizado cuando un enlace es correcto pero el recorrido de lectura no lo es.

## Referencia

- [Lychee](https://github.com/lycheeverse/lychee)
