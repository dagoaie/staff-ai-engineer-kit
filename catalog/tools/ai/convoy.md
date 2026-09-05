# Convoy

**Qué resuelve:** orquestación de un flujo de implementación y revisión sobre OpenCode a partir de un PRD.

## Cuándo aporta valor

Convoy compensa cuando un cambio requiere fases repetibles —descubrimiento, implementación, revisión y síntesis— y quieres una traza de cada fase. Para una corrección de una línea, el coste de orquestación es mayor que el beneficio. El PRD debe contener objetivo, restricciones y criterios de aceptación observables.

## Uso diario

```sh
convoy --version
convoy --help
convoy init
```

Revisa el plan, el coste y los modelos configurados antes de lanzar un pipeline. Convoy coordina trabajo, pero no sustituye la revisión humana ni los controles CI.

## Antes de lanzar

Confirma rama, árbol limpio o cambios conocidos, presupuesto y el destino de los artefactos. Ejecuta el pipeline en una rama de trabajo, no directamente sobre `main`.

## Combinado con

Antes de iniciar un pipeline, define el cambio con [OpenSpec](openspec.md) y valida el árbol con Git:

```sh
openspec new <cambio>
git status --short
convoy --help
```

Fuente: [Convoy](https://github.com/Inakitajes/convoy).
