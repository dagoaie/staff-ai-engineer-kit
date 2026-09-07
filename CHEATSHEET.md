# Cheatsheet

Referencia rápida para un Staff AI Engineer. Cada comando tiene una explicación breve; el [catálogo](catalog/README.md) cubre opciones, límites y flujos completos.

## Bootstrap

| Comando | Para qué sirve |
| --- | --- |
| `./bootstrap/setup-macos.sh --status` | Audita qué partes del toolkit faltan sin modificar el equipo. |
| `./bootstrap/setup-macos.sh --select` | Abre el selector de categorías instalables. |
| `./bootstrap/setup-macos.sh --select "1Password CLI"` | Instala automáticamente la categoría de seguridad. |
| `./bootstrap/setup-macos.sh --only agents,security` | Instala solo agentes y controles de seguridad. |
| `./bootstrap/setup-macos.sh --start-podman` | Deja lista la máquina virtual de Podman. |

## Glow: documentación legible en terminal

| Comando | Para qué sirve |
| --- | --- |
| `glow README.md` | Lee el README renderizado en terminal. |
| `glow catalog/README.md` | Abre el índice del catálogo de herramientas. |
| `glow catalog/tools/ai/codex.md` | Consulta la guía de Codex sin salir de la terminal. |
| `glow -w 100 catalog/recipes/03-evaluar-cambio-ai.md` | Renderiza una guía con el ancho de lectura elegido. |
| `fd -e md docs \| fzf \| xargs -r glow` | Busca y abre interactivamente un documento Markdown. |

## Búsqueda y navegación

| Comando | Para qué sirve |
| --- | --- |
| `rg 'TODO\|FIXME'` | Localiza deuda técnica marcada. |
| `rg -n 'OPENAI_API_KEY' --glob '!*.lock'` | Detecta posibles secretos en código y configuración. |
| `rg --files -g '*.md'` | Lista exclusivamente la documentación Markdown. |
| `fd -e yaml config/` | Encuentra configuraciones YAML bajo `config/`. |
| `rg --files \| fzf \| xargs -r "$EDITOR"` | Selecciona y abre rápidamente un archivo del repositorio. |

## Entorno reproducible y tareas

| Comando | Para qué sirve |
| --- | --- |
| `mise use --local python@3.13` | Fija Python para el repositorio actual. |
| `mise install` | Instala las versiones declaradas en `mise.toml`. |
| `mise current` | Muestra los runtimes activos y su procedencia. |
| `direnv status` | Comprueba el estado del entorno cargado por directorio. |
| `just --list` | Enumera las tareas reproducibles del proyecto. |

## Datos, configuración y documentación

| Comando | Para qué sirve |
| --- | --- |
| `jq -r '.items[].name' response.json` | Extrae nombres de una respuesta JSON. |
| `yq '.services' compose.yaml` | Inspecciona servicios definidos en YAML. |
| `bat --diff before.yaml after.yaml` | Compara dos ficheros con formato legible. |
| `markdownlint-cli2 "README.md" "catalog/**/*.md" "playbook/**/*.md"` | Detecta problemas estructurales de Markdown. |
| `lychee README.md 'catalog/**/*.md' 'playbook/**/*.md'` | Valida enlaces de la documentación. |

## Git: inspección antes de cambiar

| Comando | Para qué sirve |
| --- | --- |
| `git status --short` | Muestra el árbol de trabajo de forma compacta. |
| `git diff --check` | Detecta espacios erróneos y marcadores conflictivos. |
| `git log --oneline --decorate -10` | Revisa los diez cambios más recientes. |
| `git switch -c <tipo>/<cambio>` | Crea y cambia a una rama de trabajo. |
| `git diff \| delta` | Lee el diff con resaltado y formato mejorados. |

## Seguridad y supply chain

| Comando | Para qué sirve |
| --- | --- |
| `gitleaks detect --redact --source .` | Busca secretos sin mostrarlos en la salida. |
| `trivy fs .` | Analiza vulnerabilidades y configuración del repositorio. |
| `trivy config .` | Se centra en fallos de configuración e IaC. |
| `semgrep scan --config auto` | Ejecuta reglas de análisis estático relevantes. |
| `syft dir:. -o cyclonedx-json > sbom.json && grype sbom:sbom.json` | Genera un SBOM y analiza sus vulnerabilidades. |

## Secretos e identidades

| Comando | Para qué sirve |
| --- | --- |
| `op account list` | Lista las cuentas de 1Password disponibles. |
| `op whoami` | Confirma la identidad activa antes de automatizar. |
| `op run --env-file .env.op -- promptfoo eval` | Ejecuta evaluaciones resolviendo referencias secretas temporalmente. |
| `sops --decrypt secrets.enc.yaml` | Descifra un fichero SOPS autorizado para inspección. |
| `ssh-add -l -E sha256` | Comprueba las claves SSH cargadas en el agente. |

## Evaluación AI y MCP

| Comando | Para qué sirve |
| --- | --- |
| `promptfoo init` | Inicializa una suite de evaluación en el proyecto. |
| `promptfoo eval` | Ejecuta los casos y umbrales declarados. |
| `promptfoo view` | Abre los resultados de evaluación. |
| `promptfoo redteam init --no-gui` | Prepara pruebas adversariales sin interfaz gráfica. |
| `mcp-inspector --cli -- <comando-del-servidor>` | Inspecciona localmente un servidor MCP. |

## OpenSpec: especificar cambios antes de implementarlos

| Comando | Para qué sirve |
| --- | --- |
| `openspec init` | Inicializa los artefactos de especificación en un repositorio. |
| `openspec new <cambio>` | Crea una propuesta de cambio con alcance explícito. |
| `openspec status` | Muestra el estado de las especificaciones abiertas. |
| `openspec validate --help` | Muestra las validaciones disponibles antes de cerrar un cambio. |
| `openspec --help` | Consulta los subcomandos y opciones de la versión instalada. |

Para cambios AI relevantes, ejecuta también `openspec validate --help` para elegir la validación disponible y sigue el [workflow OpenSpec AI](playbook/openspec-ai-change-workflow.md).

## Skills for Real Engineers: invocaciones para el agente

| Invocación | Para qué sirve |
| --- | --- |
| `/grill-with-docs` | Cuestiona un plan contra el modelo y documentación existentes, y actualiza las decisiones que se aclaren. |
| `/grill-me` | Somete un plan o diseño a preguntas exigentes hasta resolver sus supuestos. |
| `/teach` | Pide una explicación práctica de una herramienta o concepto en el contexto del repositorio. |
| `/tdd` | Aplica el ciclo red-green-refactor para una funcionalidad o corrección. |
| `/to-issues` | Convierte un plan, PRD o especificación en issues independientes y ejecutables. |

Estas invocaciones aparecen solo si fueron seleccionadas durante la instalación de [Skills for Real Engineers](catalog/agent-extensions/skills/skills-for-real-engineers.md). Para instalar o actualizar esa colección: `npx skills@latest add mattpocock/skills`.

## Agentes de código

| Comando | Para qué sirve |
| --- | --- |
| `codex login` | Autentica Codex de manera interactiva. |
| `codex` | Inicia una sesión de Codex en el repositorio actual. |
| `opencode` | Inicia OpenCode con el proveedor configurado. |
| `herdr agent list` | Muestra los agentes gestionados en la sesión de Herdr. |
| `convoy init` | Prepara Convoy para un flujo guiado por PRD. |

## Contenedores con Podman

| Comando | Para qué sirve |
| --- | --- |
| `podman machine start` | Inicia la máquina virtual de contenedores en macOS. |
| `podman info` | Verifica la conexión y configuración del motor. |
| `podman build -t <imagen>:<tag> .` | Construye una imagen desde el directorio actual. |
| `podman run --rm -p 8080:8080 <imagen>:<tag>` | Ejecuta una imagen local exponiendo su puerto. |
| `podman compose up -d` | Arranca el conjunto de servicios en segundo plano. |

## APIs, datos y decisiones de arquitectura

| Comando | Para qué sirve |
| --- | --- |
| `http GET http://localhost:8080/health` | Comprueba el healthcheck de un servicio local. |
| `duckdb -c "SELECT * FROM read_json_auto('artifacts/eval-results.json') LIMIT 20;"` | Explora resultados de evaluación JSON localmente. |
| `d2 docs/architecture/model-routing.d2 docs/architecture/model-routing.svg` | Renderiza un diagrama versionable de arquitectura. |
| `adr list --adr-dir docs/decisions` | Lista las decisiones arquitectónicas registradas. |
| `adr new --adr-dir docs/decisions "<decisión>"` | Crea un ADR para una decisión duradera. |

## Kubernetes y Helm: lectura y validación

| Comando | Para qué sirve |
| --- | --- |
| `kubectl config current-context` | Confirma el clúster activo antes de operar. |
| `kubectl get pods -n <namespace>` | Lista los pods de un namespace. |
| `kubectl logs deploy/<nombre> -n <namespace> --tail=100` | Lee los últimos logs de un despliegue. |
| `kubectl rollout status deploy/<nombre> -n <namespace>` | Espera y comprueba el resultado de un rollout. |
| `helm template <release> <chart> -f values.yaml \| kubectl diff -f -` | Revisa el cambio renderizado antes de aplicarlo. |

## Contextos cloud y operación interactiva

| Comando | Para qué sirve |
| --- | --- |
| `gcloud auth list` | Verifica la cuenta de Google Cloud activa. |
| `gcloud config list` | Muestra proyecto, región y configuración activos. |
| `gcloud projects list` | Lista los proyectos accesibles. |
| `kubectx <contexto-sandbox>` | Cambia explícitamente al contexto Kubernetes indicado. |
| `k9s --namespace <namespace>` | Abre una vista interactiva limitada a un namespace. |

## IaC y diagnóstico de producción

| Comando | Para qué sirve |
| --- | --- |
| `tofu fmt -check` | Comprueba el formato de OpenTofu sin modificar ficheros. |
| `tofu validate` | Valida la configuración de infraestructura. |
| `tflint --recursive` | Ejecuta reglas de lint en todos los módulos. |
| `tofu plan -out=tfplan` | Genera un plan revisable antes de aplicar cambios. |
| `stern -n <namespace> -l app=<app> --tail 50 \| rg 'error\|timeout\|trace_id'` | Sigue logs de varios pods y filtra señales de incidencia. |

## LLM local

| Comando | Para qué sirve |
| --- | --- |
| `llmfit` | Recomienda modelos que encajan con el hardware local. |
| `lms ls` | Lista los modelos instalados en LM Studio. |
| `lms ps` | Muestra los modelos o servidores en ejecución. |
| `lms server start` | Inicia el servidor local de LM Studio. |
| `lms chat` | Abre un chat con un modelo local. |

## Colaboración en GitLab

| Comando | Para qué sirve |
| --- | --- |
| `glab auth status` | Comprueba la autenticación de GitLab. |
| `glab repo view` | Muestra los datos del proyecto actual. |
| `glab mr checks` | Consulta los checks de la merge request. |
| `glab pipeline list` | Lista los pipelines recientes. |
| `glab-tui` | Abre la interfaz terminal para GitLab. |

## Antes de abrir una MR

| Comando | Para qué sirve |
| --- | --- |
| `gitleaks detect --source .` | Evita publicar secretos por error. |
| `semgrep scan --config auto` | Busca patrones de seguridad antes de revisión. |
| `trivy fs .` | Revisa dependencias y configuración vulnerable. |
| `promptfoo eval` | Comprueba que un cambio AI no degrada los casos definidos. |
| `git diff --check` | Evita errores de formato simples en el diff. |

Ejecuta evaluación, despliegue y escaneo desde el repositorio de la aplicación correspondiente. No incluyas secretos en comandos, historial ni ficheros versionados.
