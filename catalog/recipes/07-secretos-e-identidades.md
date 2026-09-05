# Receta: gestionar secretos e identidades

Objetivo: cambiar de Mac o de proyecto sin copiar `.env` en claro ni mezclar credenciales personales y corporativas.

## Elegir el almacenamiento correcto

| Caso | Mecanismo | Qué se versiona |
| --- | --- | --- |
| Token local de un único usuario | Keychain con `security` | Nada |
| Token personal que debe estar en varios equipos | 1Password CLI | Referencias `op://`, nunca valores |
| Secreto de proyecto/equipo | SOPS + GCP KMS | El fichero cifrado y `.sops.yaml` |
| Clave Git/SSH | Par SSH separado y agente/Keychain | Solo clave pública y configuración |

## Proyecto personal

Guarda la clave en el vault y deja solo referencias en un fichero ignorado o plantilla no sensible:

```dotenv
# .env.op; se puede versionar porque no contiene el valor
OPENAI_API_KEY=op://dagocareer/openai-api-key/credential
```

```sh
op run --env-file .env.op -- just eval
```

## Proyecto compartido

Usa una clave de GCP KMS administrada por el equipo y crea reglas SOPS versionadas:

```yaml
# .sops.yaml
creation_rules:
  - path_regex: secrets/.*\.enc\.yaml$
    gcp_kms: projects/<PROJECT_ID>/locations/global/keyRings/<KEYRING>/cryptoKeys/<KEY>
```

```sh
sops secrets/dev.enc.yaml
gitleaks detect --source .
```

El IAM de KMS decide quién descifra; no distribuyas una clave privada age para resolver un problema de equipo.

## Identidades Git

Genera claves separadas, carga las passphrases con Keychain y usa `includeIf` de Git según el directorio. Añade las claves públicas de autenticación y firma a cada plataforma Git; después valida cada identidad:

```sh
ssh-add -l -E sha256
git config --show-origin --get user.email
git config --show-origin --get user.signingkey
```

## Reglas de salida

- Ningún secreto aparece en `git status`, `git diff`, historial de shell, argumentos de proceso o logs CI.
- Un colaborador con IAM aprobado puede descifrar secretos de su entorno, y otro sin ese permiso no.
- Cada repositorio usa email, remoto SSH y clave de firma correspondientes a su identidad.

Herramientas: [1Password CLI](../tools/security/onepassword-cli.md), [Keychain CLI](../tools/security/macos-keychain.md), [SOPS](../tools/security/sops.md), [Gitleaks](../tools/security/gitleaks.md), [OpenSSH](../tools/security/ssh.md), [Git](../tools/productivity/git.md).
