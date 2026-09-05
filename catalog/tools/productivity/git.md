# Git

**Qué resuelve:** versionado, revisión y trazabilidad de cambios.

## Uso diario

```sh
git status --short
git switch -c <tipo>/<cambio>
git diff --check
git log --oneline --decorate -10
git rebase origin/main
```

No reescribas ramas compartidas sin coordinación. Antes de enviar, revisa autor, estado y secretos.

## Combinado con

Audita cambios antes de abrir una MR con [Gitleaks](../security/gitleaks.md):

```sh
gitleaks detect --source .
git diff --check
```

Fuente: [Git Documentation](https://git-scm.com/doc).
