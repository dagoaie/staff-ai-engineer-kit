# Zsh

**Qué resuelve:** shell interactiva predeterminada para este entorno. `bootstrap/setup-macos.sh` añade un bloque gestionado a `~/.zshrc` con `~/.local/bin`, mise y direnv.

## Uso diario

```sh
echo "$SHELL"
source ~/.zshrc
autoload -Uz compinit && compinit
print -l -- $path
```

Edita tu configuración personal fuera del bloque `macos_setup`; el instalador identifica ese bloque para no duplicarlo.

## Combinado con

Activa variables locales solo después de revisar el fichero:

```sh
direnv allow
direnv status
```

Fuente: [Zsh Documentation](https://zsh.sourceforge.io/Doc/).
