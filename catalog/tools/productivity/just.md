# just

**Qué resuelve:** tareas reproducibles declaradas en un `justfile` del repositorio.

## Uso diario

```sh
just --list
just <tarea>
just --dry-run <tarea>
just --evaluate
```

Versiona el `justfile`, documenta efectos laterales y ofrece tareas de lectura antes de tareas que despliegan.

## Combinado con

Centraliza las comprobaciones de calidad antes de una MR:

```make
check:
  gitleaks detect --source .
  semgrep scan --config auto
  trivy fs .
```

Fuente: [just manual](https://just.systems/man/en/).
