# glab

**Qué resuelve:** CLI de GitLab para autenticar, gestionar proyectos, issues, merge requests y pipelines.

## Uso diario

```sh
glab auth login
glab repo view
glab mr create
glab mr checks
glab pipeline list
```

Confirma host, proyecto y rama antes de crear o fusionar una MR. No pases tokens mediante argumentos visibles en el historial.

## Combinado con

Verifica el árbol y crea una MR desde una rama revisada con [Git](../productivity/git.md):

```sh
git status --short
git push -u origin HEAD
glab mr create
```

Fuente: [glab Documentation](https://docs.gitlab.com/cli/).
