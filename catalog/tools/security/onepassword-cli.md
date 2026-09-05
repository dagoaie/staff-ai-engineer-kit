# 1Password CLI (`op`)

**Qué resuelve:** vault sincronizado para secretos personales y de desarrollo, con acceso desde terminal y referencias que evitan escribir el valor en ficheros de proyecto.

## Requisito y alcance

El bootstrap instala `1password-cli` y la aplicación 1Password para macOS, que habilita la integración local y autorización con Touch ID. Crea vaults separados —por ejemplo, `Personal`, `dagocareer` y el vault corporativo— y no mezcles secretos de trabajo con los personales.

## Uso diario

```sh
op --version
op account list
op vault list
op item list --vault dagocareer
op item get <item> --vault dagocareer
```

La primera llamada requiere que la app esté desbloqueada y la integración CLI habilitada. Comprueba `op whoami` antes de automatizar para no leer del vault o cuenta equivocados.

## Referencias, no texto plano

Un fichero de plantilla puede contener referencias como esta, nunca el valor:

```dotenv
OPENAI_API_KEY=op://dagocareer/openai-api-key/credential
```

Ejecuta el proceso en un entorno temporal:

```sh
op run --env-file .env.op -- promptfoo eval
```

No uses `op read` dentro de `~/.zshrc` o `.envrc`: extendería la vida del secreto a toda la sesión de shell.

## Combinado con

Usa `op run` para el proceso de evaluación y deja que [direnv](../fundamentals/direnv.md) cargue solo configuración no secreta:

```sh
direnv allow
op run --env-file .env.op -- just eval
```

Fuente: [1Password CLI](https://www.1password.dev/cli/get-started) y [secret references](https://developer.1password.com/docs/cli/secrets-scripts).
