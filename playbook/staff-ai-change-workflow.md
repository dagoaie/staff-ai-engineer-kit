# Workflow de cambio para Staff AI Engineer

Este workflow usa las skills de Matt Pocock para aclarar decisiones y Convoy para ejecutar y verificar cambios. No asigna fases a roles: la persona responsable del cambio conserva el contexto y decide los gates.

## Principios

- Empieza por la evidencia y el problema; no por una herramienta o un pipeline.
- Escala el rigor según impacto en usuario, seguridad, datos, coste o reversibilidad.
- Convoy automatiza trabajo repetible, pero no sustituye los juicios de alcance, riesgo y aceptación.
- Un hallazgo no se corrige automáticamente: primero se demuestra, se prioriza y se acepta.

## Fases

| Fase | Entrada | Trabajo | Gate | Salida |
| --- | --- | --- | --- | --- |
| 1. Encuadre | Problema, señales y contexto técnico | Investiga el sistema; usa `/grill-with-docs` para contrastar el cambio con el dominio y decisiones existentes. Usa `/grill-me` si quedan alternativas o supuestos importantes. | Objetivo, no-objetivos, riesgos y owner claros. | Nota de decisión, ADR o actualización de `CONTEXT.md`, según corresponda. |
| 2. Especificación | Encuadre acordado | Redacta PRD o RFC proporcional; para cambios AI relevantes crea y valida artefactos OpenSpec. Define comportamiento observable y criterios de aceptación. | Alcance, datos, seguridad, evaluación, coste y rollback están cubiertos en proporción al riesgo. | PRD/RFC/OpenSpec listo para implementar. |
| 3. Implementación | Especificación y criterios de aceptación | Ejecuta `convoy -p implement` para una feature, o implementa un cambio pequeño con `/tdd`. Revisa los commits y el resumen de cada fase. | El cambio cumple la especificación y los tests/evaluaciones relevantes pasan. | Rama implementada con evidencia de pruebas. |
| 4. Endurecimiento | Diff y evidencia de implementación | Ejecuta `convoy -p review` para obtener un informe sin modificar código. Contrasta los hallazgos con la especificación y el dominio. | Solo se aceptan hallazgos reproducibles, relevantes y dentro de alcance. | Lista priorizada de acciones aceptadas, descartadas o diferidas. |
| 5. Cierre | Hallazgos aceptados | Usa `convoy -p fixer` para hallazgos concretos y demostrables, o corrige manualmente cuando implique una decisión. Ejecuta `convoy -p ship` antes de abrir la MR. | CI, evaluación, seguridad y revisión humana satisfacen el umbral del cambio. | MR lista, trazabilidad de decisiones y backlog de deuda explícito. |

## Comandos por fase

Ejecuta los comandos desde la raíz del repositorio. Sustituye `<cambio>` por un identificador estable de OpenSpec. Las invocaciones con `/` se escriben al agente y no en la terminal.

### Contrato de contexto entre ejecuciones Convoy

Cuando el repositorio usa OpenSpec, `--change <cambio>` es el contrato estable entre `implement`, `review`, `fixer` y `ship`: Convoy adjunta automáticamente `proposal.md`, `design.md`, `tasks.md`, los delta specs y los specs canónicos a cada fase. No repitas ese directorio con `--file`.

Usa `--file` solo para contexto adicional que no pertenezca al bundle OpenSpec: ADRs, fixtures, scorecards o una evaluación concreta. Cada ejecución conserva por separado sus informes privados bajo `~/.convoy/runs/<run-id>/reports/`; un informe de `review` no se convierte automáticamente en la orden de un `fixer` posterior.

El puente es un *fix brief* versionado, por ejemplo `docs/reviews/<cambio>-fix-brief.md`. Tras la review, pulsa `i` y pide a OpenCode que lea el spec y los informes, clasifique los hallazgos y redacte ese brief con **solo** los aceptados. Cada entrada debe incluir evidencia, comportamiento esperado, prueba de regresión requerida, alcance permitido y no-objetivos.

### 1. Encuadre

Estas invocaciones hacen que el agente cuestione el cambio antes de convertirlo en trabajo de implementación:

```text
/grill-with-docs Quiero cambiar <capacidad>; contrasta el plan con el dominio, ADRs y documentación existente.
/grill-me Cuestiona los supuestos, alternativas y riesgos de este cambio: <resumen>.
```

Estas consultas localizan la evidencia existente, muestran la decisión relevante y confirman el estado inicial del árbol:

```sh
# Busca referencias del dominio o de la capacidad en el repositorio.
rg -n '<término-de-dominio>|<capacidad>' .
# Renderiza el ADR para revisar la decisión en su contexto.
glow docs/decisions/<adr-relevante>.md
# Muestra cambios locales que podrían contaminar el análisis.
git status --short
```

Si el cambio requiere coordinación, convierte la especificación resultante en trabajo independiente:

```text
/to-issues Convierte <PRD-o-spec> en issues pequeños con criterios de aceptación y dependencias explícitas.
```

### 2. Especificación

Estos comandos crean el cambio OpenSpec y muestran qué validaciones admite la versión instalada:

```sh
# Crea los artefactos OpenSpec para el cambio indicado.
openspec new <cambio>
# Lista los cambios OpenSpec abiertos y su estado.
openspec status
# Muestra las variantes de validación soportadas localmente.
openspec validate --help
```

Completa los artefactos de `openspec/changes/<cambio>/` y enlaza los ADR, scorecard de evaluación, presupuesto de coste/latencia o límites MCP que apliquen. Antes de implementar, comprueba que la propuesta expresa qué debe ocurrir y cómo se medirá, no solo una lista de tareas.

### 3. Implementación

Primero inspecciona el plan resuelto de Convoy; no cambia el repositorio ni inicia agentes:

```sh
convoy --change <cambio> --pipeline implement \
  --file docs/decisions/<adr-relevante>.md \
  --file evals/<suite-relevante>.yaml --plan
```

Después ejecuta el mismo comando sin `--plan`:

```sh
convoy --change <cambio> --pipeline implement \
  --file docs/decisions/<adr-relevante>.md \
  --file evals/<suite-relevante>.yaml
```

`--change` da a Convoy el objetivo y la especificación completos; `--file` adjunta únicamente la evidencia adicional. Convoy también entrega el diff acumulado y los informes de fases previas a los agentes posteriores. Sin OpenSpec, usa `--prompt-file <prd.md>` como contrato principal. Para una corrección pequeña, evita la orquestación completa y aplica TDD de forma directa:

```text
/tdd Implementa <cambio> guiado por estos criterios de aceptación: <enlace-o-resumen>.
```

### 4. Endurecimiento

La revisión es de solo lectura: no arregla código. Conserva el mismo contrato y adjuntos que guiaron la implementación.

Para aplicar el gate completo desde OpenCode sin corregir ni publicar, invoca la skill local:

```text
/harden-change Verifica el cambio OpenSpec <cambio> ya implementado en este repositorio. No modifiques código ni ejecutes ship.
```

Este comando genera un informe y un score sobre el diff actual; `convoy runs` permite abrir después esa ejecución y sus artefactos:

```sh
# Ejecuta una revisión de solo lectura sobre el cambio y sus adjuntos.
convoy --change <cambio> --pipeline review \
  --file docs/decisions/<adr-relevante>.md \
  --file evals/<suite-relevante>.yaml
# Abre el historial y los informes de las ejecuciones de Convoy.
convoy runs
```

En el dashboard de la ejecución, pulsa `i` para abrir OpenCode con el PRD y los informes como contexto. Reproduce los hallazgos que parezcan bloqueantes y crea `docs/reviews/<cambio>-fix-brief.md` con los aceptados. Un informe de Convoy es evidencia para decidir; no es una orden de modificar el diff.

### 5. Cierre

La ruta diaria puede resolver los hallazgos durante la iteración de OpenCode y volver a ejecutar `review`. Pasa al `fixer` únicamente un fix brief con hallazgos aceptados, finitos y demostrables; es una ejecución independiente, no una fase interna de `review`:

Este comando muestra el plan que seguiría `fixer` con los hallazgos triados, sin iniciar agentes ni modificar código:

```sh
# Previsualiza las fases y el contexto con que `fixer` trataría los hallazgos.
convoy --change <cambio> --pipeline fixer \
  --prompt-file docs/reviews/<cambio>-fix-brief.md \
  --file docs/decisions/<adr-relevante>.md \
  --file evals/<suite-relevante>.yaml --plan

# Mide y trata de cerrar la rama usando el contrato OpenSpec y sus adjuntos.
convoy --change <cambio> --pipeline ship \
  --file docs/decisions/<adr-relevante>.md \
  --file evals/<suite-relevante>.yaml
# Detecta errores de espacios y marcadores de conflicto en el diff.
git diff --check
```

Tras revisar el plan, ejecuta `fixer` de nuevo sin `--plan`. `fixer` debe demostrar cada problema con una prueba de regresión antes de cambiar producción. `ship` valida el estado final contra la base y prepara la evidencia de cierre; no reemplaza la aprobación humana ni la CI de la merge request.

## Ejemplo completo: fallback seguro para una respuesta RAG

**Situación:** el asistente de soporte responde aunque el retrieval no encuentre evidencia suficiente. El cambio debe devolver una respuesta de abstención y registrar la causa cuando la cobertura de evidencia sea baja. Afecta a comportamiento de usuario, evaluación, coste y observabilidad; por eso se usa el flujo completo.

### 1. Encuadrar la decisión

En la sesión del agente:

```text
/grill-with-docs Quiero que el asistente se abstenga cuando no haya evidencia RAG suficiente. Contrasta el cambio con el contrato de retrieval, el tono de respuestas y los ADRs de observabilidad.
/grill-me ¿Qué umbral de evidencia es seguro? Cuestiona falsos negativos, experiencia de usuario, métricas, fallback y rollback.
```

La conversación revela que el umbral no puede ser una constante arbitraria: se medirá sobre el corpus de evaluación actual, se expondrá como configuración y se incluirá el motivo de abstención en la telemetría. Se registra la decisión en `docs/decisions/adr-042-rag-abstention.md`.

Estos comandos encuentran la implementación y pruebas relacionadas, muestran el ADR y verifican que no hay cambios locales inesperados:

```sh
# Busca código, pruebas y documentación que traten retrieval, grounding o abstención.
rg -n 'retrieval|grounding|abstention' src tests docs
# Renderiza la decisión que restringe la implementación.
glow docs/decisions/adr-042-rag-abstention.md
# Comprueba que el árbol no contiene cambios locales inesperados.
git status --short
```

### 2. Especificar el cambio

Estos comandos abren un cambio OpenSpec con identidad estable y muestran los cambios activos:

```sh
# Crea el cambio OpenSpec que Convoy identificará como `rag-safe-abstention`.
openspec new rag-safe-abstention
# Muestra el cambio recién creado junto a los demás cambios activos.
openspec status
```

El directorio `openspec/changes/rag-safe-abstention/` contiene, como mínimo:

```text
proposal.md  # objetivo: abstenerse sin evidencia; no-objetivo: cambiar el proveedor LLM
specs/       # escenarios de respuesta, error y autorización
design.md    # umbral configurable, métrica, fallback y rollback
tasks.md     # código, evaluación, telemetría, documentación y rollout
```

Un criterio de aceptación observable podría ser: “en el segmento `sin-evidencia`, la tasa de respuestas inventadas es 0%; las respuestas con evidencia válida no caen más de 2 puntos porcentuales; cada abstención emite `rag_abstention_reason`”. Antes de continuar, se actualizan el scorecard y el presupuesto de coste/latencia, y se consulta la validación que corresponda:

El primer comando muestra las validaciones OpenSpec disponibles; el segundo ejecuta el baseline de evaluación que el cambio no debe degradar:

```sh
# Consulta los validadores de OpenSpec disponibles antes de seleccionar uno.
openspec validate --help
# Ejecuta la evaluación baseline para detectar degradaciones posteriores.
promptfoo eval
```

### 3. Implementar con contexto completo

Primero se revisa el plan de Convoy:

```sh
convoy --change rag-safe-abstention --pipeline implement \
  --file docs/decisions/adr-042-rag-abstention.md \
  --file evals/rag-abstention.yaml --plan
```

Al aprobar ese plan, se ejecuta sin `--plan`:

```sh
convoy --change rag-safe-abstention --pipeline implement \
  --file docs/decisions/adr-042-rag-abstention.md \
  --file evals/rag-abstention.yaml
```

`--change rag-safe-abstention` hace que Convoy adjunte el `proposal.md`, especificación, diseño y tareas de OpenSpec a cada fase. El ADR fija la decisión y la evaluación da ejemplos concretos al implementador, auditor de patrones, seguridad y tests. Revisa el resumen y los commits de las fases antes de continuar.

### 4. Revisar y aceptar hallazgos

Este comando inspecciona el diff contra el contrato OpenSpec sin editar el código y conserva los informes para abrirlos con `convoy runs`:

```sh
# Genera un informe y score de solo lectura para el cambio OpenSpec activo.
convoy --change rag-safe-abstention --pipeline review \
  --file docs/decisions/adr-042-rag-abstention.md \
  --file evals/rag-abstention.yaml
# Abre la ejecución para leer su informe y pulsar `i` para iterar.
convoy runs
```

En el dashboard del review se pulsa `i` y se pide a OpenCode: “Lee el spec y los informes de esta ejecución. Clasifica los hallazgos y crea un fix brief con solo los aceptados; no modifiques código”. Supón que el informe señala que el evento de telemetría incluye un fragmento del documento recuperado. Se reproduce el problema y OpenCode crea `docs/reviews/rag-safe-abstention-fix-brief.md`:

```md
# Fix brief: rag-safe-abstention

## H-01: posible exposición de contenido recuperado en telemetría

- Evidencia: la prueba `telemetry_does_not_include_retrieved_content` falla.
- Decisión: bloquear la MR hasta eliminar el contenido y conservar solo identificadores y motivo de abstención.
- Regresión requerida: la prueba anterior debe pasar antes de declarar el hallazgo resuelto.
```

Los hallazgos no reproducibles o fuera de alcance se documentan como descartados o deuda, pero no se pasan al fixer.

### 5. Corregir, cerrar y abrir la MR

El primer comando previsualiza el plan de corrección; el segundo ejecuta solo los hallazgos aceptados; los siguientes checks validan calidad local; y `ship` sincroniza, mide y cierra la rama:

```sh
# Muestra el plan del fixer sin iniciar agentes ni modificar la rama.
convoy --change rag-safe-abstention --pipeline fixer \
  --prompt-file docs/reviews/rag-safe-abstention-fix-brief.md \
  --file docs/decisions/adr-042-rag-abstention.md \
  --file evals/rag-abstention.yaml --plan

# Corrige únicamente los hallazgos aceptados y exige pruebas de regresión.
convoy --change rag-safe-abstention --pipeline fixer \
  --prompt-file docs/reviews/rag-safe-abstention-fix-brief.md \
  --file docs/decisions/adr-042-rag-abstention.md \
  --file evals/rag-abstention.yaml

# Ejecuta la evaluación funcional tras las correcciones.
promptfoo eval
# Busca secretos sin revelarlos en la salida.
gitleaks detect --redact --source .
# Comprueba el formato básico del diff antes del cierre.
git diff --check

# Sincroniza, mide y trata de cerrar la rama contra su base.
convoy --change rag-safe-abstention --pipeline ship \
  --file docs/decisions/adr-042-rag-abstention.md \
  --file evals/rag-abstention.yaml
```

La MR enlaza el OpenSpec, ADR, resultado de evaluación y decisión sobre H-01. Si el cambio alcanza producción, el rollout se vigila con la métrica de abstenciones, la calidad por segmento y el coste; el rollback desactiva la configuración de abstención sin borrar la telemetría necesaria para analizar el resultado.

## Selección rápida

| Situación | Ruta mínima |
| --- | --- |
| Cambio mecánico y reversible | Implementación local → tests → revisión humana. |
| Cambio funcional acotado | Encuadre breve → criterios de aceptación → `implement` → `review` → MR. |
| Cambio AI, transversal o difícil de revertir | Encuadre con skills → OpenSpec → `implement` → `review`/`fixer` → `ship` → MR. |
| Rama ya existente | Especificación o intención explícita → `review` → aceptar hallazgos → `fixer` o corrección manual → `ship`. |

## Límites deliberados

No se crean pipelines `implement-mattpocock` ni `review-mattpocock` por defecto. Las skills ayudan a llegar a una buena especificación mediante conversación; Convoy ejecuta pipelines repetibles sobre esa especificación. Crea un pipeline híbrido solo cuando haya una diferencia estable y verificable —por ejemplo, exigir un OpenSpec validado o una rúbrica de contratos de dominio— y nómbralo por ese resultado, como `implement-spec-verified`.

Las invocaciones de skills dependen de que se hayan instalado para el host de agente. Consulta [Skills for Real Engineers](../catalog/agent-extensions/skills/skills-for-real-engineers.md) y el [workflow OpenSpec AI](openspec-ai-change-workflow.md) para su configuración y nivel de detalle.
