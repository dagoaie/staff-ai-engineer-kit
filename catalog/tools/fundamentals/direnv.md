# direnv

**Qué resuelve:** carga y descarga variables de entorno al entrar y salir de un directorio.

## Uso diario

```sh
direnv edit .
direnv allow
direnv deny
direnv status
```

Revisa siempre un `.envrc` antes de aprobarlo. No guardes claves en Git: carga referencias desde el gestor de secretos corporativo.

## Combinado con

Expón configuración no sensible para [Promptfoo](../ai/promptfoo.md):

```sh
export PROMPTFOO_CACHE_PATH="$PWD/.cache/promptfoo"
layout node
```

Fuente: [direnv Documentation](https://direnv.net/).
