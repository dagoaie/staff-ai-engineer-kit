# Keychain CLI de macOS (`security`)

**Qué resuelve:** almacenamiento cifrado local para tokens personales que no necesitas compartir ni sincronizar mediante un vault externo.

## Cuándo usarlo

Úsalo para un secreto específico de este Mac. Para secretos de equipo usa [SOPS](sops.md) con KMS; para valores personales que deban sobrevivir a un cambio de equipo usa [1Password CLI](onepassword-cli.md). Keychain no sustituye una política de secretos compartidos.

## Uso diario

Guarda o actualiza un secreto sin introducirlo en el historial: deja `-w` sin valor para el prompt interactivo.

```sh
security add-generic-password \
  -U -a "$USER" -s "dagocareer/openai-api-key" -w
```

Recupéralo únicamente en el proceso que lo necesita:

```sh
OPENAI_API_KEY="$(
  security find-generic-password \
    -a "$USER" -s "dagocareer/openai-api-key" -w
)" promptfoo eval
```

No ejecutes el segundo comando con trazas de shell (`set -x`) y no imprimas el valor para “comprobarlo”.

## Combinado con

Usa Keychain para una credencial de uso individual y conserva [SOPS](sops.md) para la configuración cifrada del proyecto:

```sh
sops secrets/dev.enc.yaml
security find-generic-password -a "$USER" -s "dagocareer/openai-api-key" -w >/dev/null
```

Fuente: [Apple Keychain Services](https://developer.apple.com/documentation/security/adding-a-password-to-the-keychain).
