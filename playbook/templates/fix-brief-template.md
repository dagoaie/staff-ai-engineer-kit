# Fix brief: `<cambio>`

- **Ejecución de review:** `<run-id o enlace al informe>`
- **Especificación:** `openspec/changes/<cambio>/`
- **Autor del triage:** `<persona>`
- **Fecha:** `<AAAA-MM-DD>`

Este documento contiene solo hallazgos aceptados tras revisar su evidencia. No es una copia del informe de Convoy: los hallazgos descartados o diferidos se registran en el informe, una issue o el backlog correspondiente.

## Alcance de la corrección

- **Objetivo:** `<resultado que deben conseguir las correcciones>`
- **No-objetivos:** `<comportamiento, módulos o refactors que fixer no debe cambiar>`
- **Checks requeridos al cierre:** `<tests, evaluaciones o validaciones>`

## Hallazgos aceptados

### H-01: `<título conciso>`

- **Decisión:** `<bloquea la MR | corregir antes de ship | otro resultado aceptado>`
- **Evidencia reproducible:** `<archivo, línea, comando, salida o enlace al informe>`
- **Comportamiento actual:** `<qué sucede y por qué incumple el contrato>`
- **Comportamiento esperado:** `<resultado observable esperado>`
- **Alcance permitido:** `<archivos, módulo o comportamiento que fixer puede modificar>`
- **Regresión requerida:** `<prueba que debe crearse o ajustarse y comando para ejecutarla>`
- **No-objetivos específicos:** `<cambios explícitamente excluidos>`

<!-- Duplica esta sección por cada hallazgo aceptado. -->

## Decisión de cierre

`fixer` solo puede resolver los hallazgos listados arriba. Si descubre un problema adicional, debe reportarlo sin ampliar el alcance ni modificar código para resolverlo.
