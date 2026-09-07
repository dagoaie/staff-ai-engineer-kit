# Prepare Change

- **Origen y versión:** este repositorio, versionado con Git
- **Host compatible:** OpenCode
- **Ámbito:** personal
- **Owner / fecha de revisión:** David González / 2026-09-07

## Propósito

`/prepare-change` convierte un `review` y un `/grill-with-docs` ya cerrados en un cambio OpenSpec listo para planificar. Consolida decisiones, bloqueos, criterios de aceptación, evaluación y rollback; no implementa código ni ejecuta Convoy.

## Instalación y actualización

Desde la raíz de este repositorio, este comando crea el directorio de skills de OpenCode si aún no existe:

```sh
mkdir -p ~/.agents/skills
```

Este comando enlaza la skill versionada en el repositorio para que OpenCode la detecte; las actualizaciones del repositorio quedan disponibles sin reinstalarla:

```sh
ln -s "$(git rev-parse --show-toplevel)/skills/prepare-change" ~/.agents/skills/prepare-change
```

Invócala explícitamente después de cerrar el review y el grill:

```text
/prepare-change Usa el review y el grill-with-docs cerrados para preparar el cambio OpenSpec <cambio>. No implementes código.
```

## Riesgos y compatibilidad

La skill puede crear o actualizar documentación y artefactos OpenSpec en el repositorio de trabajo. No debe aceptar hallazgos sin evidencia, crear issues, ejecutar Convoy ni modificar código de producción. Respeta siempre `AGENTS.md` y las decisiones de arquitectura del proyecto.
