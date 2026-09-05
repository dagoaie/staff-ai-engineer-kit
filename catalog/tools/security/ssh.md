# OpenSSH, ssh-agent y firmas Git

**Qué resuelve:** autenticación de Git/servidores y firmas criptográficas de commits y tags. macOS incluye `ssh`, `ssh-keygen` y `ssh-add`.

## Separar identidades y propósitos

Mantén al menos una clave de autenticación y otra de firma para cada identidad. Ejemplo: `dagocareer_auth`, `dagocareer_sign`, `sngular_auth` y `sngular_sign`. Nunca reutilices una clave personal para una organización ni una misma clave para acceso y firma.

```sh
ssh-keygen -t ed25519 -a 100 \
  -f ~/.ssh/id_ed25519_dagocareer_auth \
  -C "dagocareer authentication"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519_dagocareer_auth
ssh-add -l -E sha256
```

## Configuración por cuenta

Usa aliases de host en `~/.ssh/config` para que Git elija la clave correcta:

```sshconfig
Host github-dagocareer
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_dagocareer_auth
  IdentitiesOnly yes
```

Un remoto personal usaría `git@github-dagocareer:dagocareer/<repo>.git`. Para firmas SSH configura `gpg.format=ssh` y una clave pública de firma en el include de Git correspondiente a la identidad, no de forma global.

## Combinado con

Separa la identidad de Git por directorio para impedir cruces entre `dagocareer` y Sngular:

```ini
[includeIf "gitdir:~/code/me/"]
  path = ~/.gitconfig-dagocareer
[includeIf "gitdir:~/code/sngular/"]
  path = ~/.gitconfig-sngular
```

Fuente: [GitHub: claves SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) y [firmas SSH](https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key).
