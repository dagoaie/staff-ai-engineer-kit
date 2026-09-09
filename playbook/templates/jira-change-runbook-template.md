# Runbook copy-paste para un cambio Jira

Duplica este runbook en la descripción del ticket, en una nota de trabajo o en el `README` del cambio. Sustituye los valores entre `<…>` antes de ejecutar comandos o enviar prompts. Es la ruta completa para un cambio AI, transversal o difícil de revertir; para una corrección mecánica usa la [selección rápida](../staff-ai-change-workflow.md#selección-rápida).

## 0. Configurar y aislar el trabajo

```zsh
# Sustituye solo estos seis valores. El nombre de rama tiene exactamente dos palabras de tarea.
JIRA_KEY="<ARS-123>"
CHANGE="<rag-safe-abstention>"
TYPE="<feat>"
TASK_WORD_1="<rag>"
TASK_WORD_2="<abstention>"
TARGET_BRANCH="<main>"
BRANCH="allfunds-core.${JIRA_KEY:l}-${TYPE}-${TASK_WORD_1}-${TASK_WORD_2}"

# Desde la rama por defecto y con el árbol limpio, crea el worktree.
wt switch --create "$BRANCH"
```

Si `wt` no cambia el directorio de la terminal, abre el worktree cuya ruta muestra el comando anterior. Desde su raíz, verifica el punto de partida:

```sh
git branch --show-current
git status --short
wt list
```

## 1. Entender y cuestionar el ticket

Lee el ticket Jira, el código relacionado, ADRs y documentación antes de comprometer alcance. Envía al agente:

```text
/grill-with-docs Quiero implementar <ARS-123>: <resumen del ticket>. Contrasta la tarea con el dominio, ADRs y documentación existente. Identifica comportamiento actual, objetivo, no-objetivos, decisiones pendientes, riesgos, criterios de aceptación y pruebas o evaluaciones necesarias. No implementes código.
```

Si persisten alternativas de diseño o supuestos de riesgo, ejecuta también:

```text
/grill-me Cuestiona los supuestos, alternativas y riesgos de <ARS-123>: <resumen>. No avances hasta que las decisiones pendientes estén explícitas.
```

Registra en un ADR o `CONTEXT.md` únicamente las decisiones ya acordadas.

## 2. Convertir las decisiones en OpenSpec

```sh
openspec new "$CHANGE"
openspec status
openspec validate --help
```

Después envía al agente:

```text
/prepare-change Usa las conclusiones del grill para preparar el cambio OpenSpec <rag-safe-abstention>. Lee los ADRs y la documentación citada; deja explícitos decisiones, bloqueos, criterios de aceptación, pruebas o evaluaciones, seguridad, observabilidad y rollback cuando apliquen. No implementes código ni ejecutes Convoy.
```

Revisa `openspec/changes/<rag-safe-abstention>/proposal.md`, `design.md`, `specs/` y `tasks.md`. El bundle es el contrato: no continúes mientras tenga decisiones sin resolver o criterios no verificables.

## 3. Previsualizar e implementar

```sh
# Sustituye implement-gpt por el perfil configurado en el repositorio, si difiere.
convoy --change "$CHANGE" --pipeline implement-gpt --plan
convoy --change "$CHANGE" --pipeline implement-gpt
```

Revisa el resumen, commits y cambios generados. Ejecuta los tests y evaluaciones que exige `tasks.md`; no inventes sustitutos.

## 4. Endurecer y triage de hallazgos

```text
/harden-change Verifica el cambio OpenSpec <rag-safe-abstention> ya implementado en este repositorio. No modifiques código ni ejecutes ship.
```

Si el gate pasa sin hallazgos aceptados, continúa al cierre. Si hay hallazgos, reproduce los potencialmente bloqueantes y envía:

```text
Lee el bundle OpenSpec del cambio <rag-safe-abstention> y los informes de esta ejecución de review. Reproduce los hallazgos potencialmente bloqueantes y clasifícalos como aceptados, descartados o diferidos. Crea docs/reviews/<rag-safe-abstention>-fix-brief.md con solo los aceptados, usando la plantilla de fix brief: evidencia reproducible, comportamiento esperado, regresión requerida, alcance permitido y no-objetivos. No modifiques código.
```

No envíes al `fixer` hallazgos no reproducibles, fuera de alcance o que requieran una decisión humana. Usa la [plantilla de fix brief](fix-brief-template.md) para el archivo resultante.

## 5. Corregir y volver a validar

Solo si existe `docs/reviews/<rag-safe-abstention>-fix-brief.md` con hallazgos aceptados:

```sh
convoy --change "$CHANGE" --pipeline fixer \
  --prompt-file "docs/reviews/$CHANGE-fix-brief.md" --plan

convoy --change "$CHANGE" --pipeline fixer \
  --prompt-file "docs/reviews/$CHANGE-fix-brief.md"
```

Tras las correcciones que afecten comportamiento, seguridad, datos o evaluaciones, repite el gate:

```text
/harden-change Verifica el cambio OpenSpec <rag-safe-abstention> ya corregido. No modifiques código ni ejecutes ship.
```

## 6. Cerrar y abrir la PR/MR

Antes de cerrar la rama, captura decisiones arquitectónicas nuevas para que queden incluidas en la evidencia final:

```text
/update-kb Recoge las decisiones arquitectónicas tomadas en <ARS-123> y actualiza la base de conocimiento del proyecto antes de cerrar la rama y abrir la PR/MR.
```

```sh
git diff --check
convoy --change "$CHANGE" --pipeline ship
git status --short
git push -u origin "$BRANCH"
```

Según el hosting del repositorio, ejecuta **solo uno** de estos comandos:

```sh
# GitLab: crea la MR contra la rama base elegida.
glab mr create --fill --source-branch "$BRANCH" --target-branch "$TARGET_BRANCH"
```

```sh
# GitHub: crea la PR contra la rama base elegida.
gh pr create --fill --head "$BRANCH" --base "$TARGET_BRANCH"
```

En la descripción de la PR/MR incluye el identificador Jira, el bundle OpenSpec y el ADR aplicable, además de evidencia de tests, evaluaciones y hallazgos aceptados o diferidos. Tras crearla, envía al agente:

```text
/jira-integration Enlaza la PR/MR recién creada con <ARS-123>, añade un comentario con la evidencia de entrega y transiciona el ticket al estado acordado por el equipo.
```

## Gates que no se saltan

- No implementar sin decisiones y criterios de aceptación suficientes.
- No ejecutar `fixer` sin un *fix brief* con hallazgos aceptados y reproducibles.
- No ejecutar `ship` si fallan tests, validaciones o el gate de review.
- No abrir PR/MR sin revisar el diff, actualizar el conocimiento aplicable y conservar la trazabilidad con Jira y OpenSpec.
