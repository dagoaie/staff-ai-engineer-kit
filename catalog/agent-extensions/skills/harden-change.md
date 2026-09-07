# Harden Change

- **Origen y versión:** este repositorio, versionado con Git
- **Host compatible:** OpenCode
- **Ámbito:** personal
- **Owner / fecha de revisión:** David González / 2026-09-07

## Propósito

`/harden-change` ejecuta el gate de endurecimiento para un cambio OpenSpec ya implementado en el repositorio actual. Localiza los tests y evaluaciones definidos, valida el spec, comprueba el diff y lanza una review de Convoy. Solo informa: no corrige, publica ni cierra el cambio.

## Instalación y actualización

Desde la raíz de este repositorio, este comando crea el directorio de skills de OpenCode si aún no existe:

```sh
mkdir -p ~/.agents/skills
```

Este comando enlaza la skill versionada en el repositorio para que OpenCode la detecte; las actualizaciones del repositorio quedan disponibles sin reinstalarla:

```sh
ln -s "$(git rev-parse --show-toplevel)/skills/harden-change" ~/.agents/skills/harden-change
```

Invócala desde la raíz del repositorio que contiene el cambio, sustituyendo el identificador OpenSpec:

```text
/harden-change Verifica el cambio OpenSpec <cambio> ya implementado en este repositorio. No modifiques código ni ejecutes ship.
```

## Riesgos y compatibilidad

La skill ejecuta tests, evaluaciones, validaciones OpenSpec y una review de Convoy; puede consumir tiempo y créditos de los proveedores configurados. Si el árbol contiene cambios ajenos, se detiene antes de lanzar la review. Respeta siempre `AGENTS.md` y no acepta hallazgos ni modifica el repositorio.
