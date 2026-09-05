# Homebrew

**Qué resuelve:** gestor de paquetes para macOS. Este bootstrap lo usa para fórmulas CLI y aplicaciones.

## Uso diario

```sh
brew search <herramienta>
brew install <formula>
brew upgrade <formula>
brew info <formula>
```

No ejecutes `brew upgrade` global sin revisar los cambios: puede actualizar runtimes usados por proyectos.

## Combinado con

Instala un binario global con Brew y fija la versión de runtime por proyecto con [mise](mise.md):

```sh
brew install uv
mise use --local python@3.13
```

Fuente: [Homebrew](https://docs.brew.sh/).
