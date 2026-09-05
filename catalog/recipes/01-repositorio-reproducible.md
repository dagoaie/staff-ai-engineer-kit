# Receta: repositorio reproducible

Objetivo: cualquier colaborador puede activar runtimes, variables no sensibles y comprobaciones locales con el mismo contrato.

## Pasos

```sh
git init
mise use --local node@24 python@3.13
printf '%s\n' 'layout python' > .envrc
direnv allow
```

Crea un `justfile` con una tarea de control:

```make
check:
  gitleaks detect --source .
  semgrep scan --config auto
  trivy fs .
```

Ejecuta y revisa antes del primer commit:

```sh
just check
git diff --check
git add mise.toml .envrc justfile
git commit -m "chore: bootstrap project tooling"
```

## Guardrails

- No incluyas secretos en `.envrc`; carga referencias desde el gestor corporativo.
- Versiona `mise.toml` y `justfile`; revisa `.envrc` antes de ejecutar `direnv allow`.
- Añade reglas Semgrep y umbrales Trivy propios cuando el proyecto los necesite.

Herramientas: [Git](../tools/productivity/git.md), [mise](../tools/fundamentals/mise.md), [direnv](../tools/fundamentals/direnv.md), [just](../tools/productivity/just.md), [Gitleaks](../tools/security/gitleaks.md), [Semgrep](../tools/security/semgrep.md), [Trivy](../tools/security/trivy.md).
