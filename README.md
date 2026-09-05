# Staff AI Engineer Kit

Kit personal para un Staff AI Engineer: bootstrap reproducible de macOS, catálogo de herramientas y playbook de prácticas AI. El bootstrap es **idempotente**: se puede volver a ejecutar y solo instala lo que falta o actualiza las herramientas gestionadas por `uv`.

## Mapa del kit

- [`bootstrap/`](bootstrap/): prepara el Mac y contiene el inventario instalable.
- [`catalog/`](catalog/README.md): explica herramientas, extensiones de agente y recetas operativas.
- [`playbook/`](playbook/README.md): reúne decisiones, plantillas y workflows de Staff AI Engineer.

El bootstrap instala capacidades globales; el catálogo enseña a utilizarlas; el playbook decide cuándo y para qué aplicarlas. Las dependencias de una aplicación —por ejemplo, DeepEval o Docling— se declaran con `uv` dentro de su propio repositorio.

## Uso

```sh
git clone <tu-fork-o-repositorio> ~/code/staff-ai-engineer-kit
cd ~/code/staff-ai-engineer-kit
./bootstrap/setup-macos.sh
```

Por defecto instala las herramientas y configura los ficheros locales, pero no crea ni arranca una máquina virtual de Podman. Para dejar también los contenedores listos:

```sh
./bootstrap/setup-macos.sh --start-podman
```

Opciones útiles:

```text
./bootstrap/setup-macos.sh --dry-run           # muestra los comandos sin ejecutarlos
./bootstrap/setup-macos.sh --skip-skills       # omite el asistente interactivo de Skills
./bootstrap/setup-macos.sh --skip-apps         # omite Ghostty, LM Studio y la app 1Password
./bootstrap/setup-macos.sh --start-podman      # crea/inicia la VM de Podman si hace falta
./bootstrap/setup-macos.sh --status            # audita el equipo y sugiere categorías pendientes
./bootstrap/setup-macos.sh --select            # selector interactivo de categorías
./bootstrap/setup-macos.sh --select "1Password CLI"  # selecciona automáticamente la categoría security
./bootstrap/setup-macos.sh --only agents,security  # instala solo categorías concretas
```

`--status` no instala ni modifica nada. Muestra las herramientas clave disponibles en `PATH` y propone un comando `--only` para las categorías que falten. El selector funciona sin depender de `fzf`, por lo que también sirve en un Mac recién configurado. Sin argumentos abre el menú; con una herramienta o categoría, `--select` la resuelve automáticamente (`--select "1Password CLI"`, `--select security`).

Las categorías son: `base`, `productivity`, `environment`, `containers`, `platform`, `security`, `collaboration`, `agents`, `local-llm` y `terminal`. Sin `--only` ni `--select`, el script conserva el comportamiento original e instala todo el toolkit.

El script debe ejecutarse desde una sesión con Internet. Homebrew puede solicitar la contraseña de macOS durante su propia instalación. Ninguna credencial se escribe en el repositorio.

## Qué instala

| Grupo | Herramientas |
| --- | --- |
| Base y productividad | Homebrew, Zsh, Node.js, `uv`, `jq`, `yq`, Git, Delta, `rg`, `fd`, `fzf`, `bat`, Glow, `just`, HTTPie, `btop`, DuckDB, D2, adr-tools, markdownlint-cli2 y Lychee |
| Entornos reproducibles | `mise` y `direnv` |
| Contenedores | Podman y LazyDocker, configurado para ejecutar `podman` / `podman compose` |
| Plataforma | `kubectl`, Helm, K9s, Kubectx/Kubens, OpenTofu, TFLint y Stern |
| Terminal | Ghostty, Herdr |
| Agentes y protocolos | OpenCode, OpenAI Codex, Convoy, OpenSpec y MCP Inspector |
| Git / cloud | GitLab CLI (`glab`), `glab-tui`, Google Cloud SDK (`gcloud`) |
| LLM local | LM Studio (incluye `lms`) y `llmfit` |
| Calidad y seguridad | Promptfoo, Gitleaks, Trivy, Syft, Grype, Cosign, Semgrep, SOPS, age, 1Password CLI, Keychain de macOS y OpenSSH |
| Skills | El instalador oficial interactivo de Skills for Real Engineers |

DeepEval y Docling se documentan como dependencias de proyecto gestionadas con `uv`; no forman parte de la instalación global porque fijar sus versiones, modelos y dependencias de procesamiento es parte del contrato de cada aplicación AI.

## Después de instalar

Abre una terminal nueva (o ejecuta `source ~/.zshrc`) y completa únicamente las autenticaciones que necesitas:

```sh
codex login
gcloud init
glab auth login
opencode
op account list
```

`lms` forma parte de la app LM Studio; ábrela una vez antes de usar el CLI. Si se ejecutó con `--start-podman`, comprueba el entorno con `podman info`.

## Guías de herramientas

La guía operativa de cada herramienta y las recetas que las combinan están en [el catálogo](catalog/README.md). Úsala como referencia de trabajo diario tras ejecutar el bootstrap.

Para orientar el toolkit hacia el impacto de un Staff AI Engineer —mapas de sistemas, estrategia, scorecards de evaluación y operación— consulta el [playbook](playbook/README.md). Es deliberadamente independiente de proveedor y complementa, no sustituye, las políticas de cada organización.

La [guía de documentación Staff](playbook/documentation-decision-matrix.md) indica cuándo crear PRD, RFC, HLD, FDD, LLD, ADR, estrategia y fichas AI; no todos los cambios requieren todos los documentos.

Para leerla desde terminal con formato Markdown, usa Glow:

```sh
glow catalog/README.md
```

## Flujo base de Staff AI Engineer

El bootstrap instala herramientas; no intenta imponer políticas de cada organización. Esta es la práctica recomendada para convertirlas en un sistema de trabajo:

1. **Entorno por repositorio.** Declara versiones en `mise.toml` y secretos/variables no sensibles en `.envrc`. No añadas secretos a ninguno de los dos ficheros si van a Git; carga referencias mediante 1Password, Vault u otro gestor aprobado.
2. **Evaluaciones como código.** En cada aplicación LLM, guarda corpus, casos adversariales, aserciones y umbrales junto al código. Empieza con `promptfoo init` y ejecútalo en CI antes de variar prompts, modelos, RAG o herramientas.
3. **Seguridad desde el cambio local.** Ejecuta `gitleaks`, `semgrep` y `trivy fs` antes de abrir una MR. Genera un SBOM con `syft` y analiza dependencias/imágenes con `grype` o `trivy`; firma solo los artefactos que lleguen a un registro con `cosign`.
4. **Observabilidad AI.** Toda llamada de producción debería aportar al menos modelo, operación, latencia, tokens, coste, resultado y motivo de fallo a tus trazas. Redacta PII, prompts y outputs antes de exportarlos. Las convenciones GenAI de OpenTelemetry cambian con frecuencia: fija su versión por proyecto y valida cualquier actualización.
5. **Secretos e identidades.** Guarda credenciales locales en Keychain o 1Password; usa SOPS con KMS para secretos compartidos. Mantén separadas las claves SSH y la identidad Git personal/de trabajo. Nunca exportes secretos desde `~/.zshrc` o `.envrc`.
6. **MCP con contrato.** Prueba cada servidor MCP localmente con `mcp-inspector`; define autorización, timeout, límites de llamadas, datos que puede exfiltrar y pruebas de regresión para cada herramienta expuesta.
7. **Infraestructura revisable.** Usa OpenTofu/TFLint por repositorio. `kubectl`, Helm y K9s son clientes de los clústeres aprobados; este bootstrap no crea un Kubernetes local porque con Podman no siempre es una necesidad y añade una capa de virtualización evitable.

Comandos útiles para empezar:

```sh
promptfoo init
mcp-inspector
gitleaks detect --source .
trivy fs .
syft . -o cyclonedx-json
semgrep scan --config auto
```

Promptfoo requiere una versión actual de Node (la documentación recomienda Node 24 LTS); Homebrew instala Node, mientras que `mise` permite fijar esa versión por repositorio.

El primer lanzamiento de `npx skills@latest add mattpocock/skills` es interactivo a propósito: permite seleccionar los skills y el host de agente sin sobrescribir configuraciones existentes. Se puede volver a lanzar con:

```sh
npx skills@latest add mattpocock/skills
```

## Configuración gestionada

- El bloque `macos_setup` de `~/.zshrc` añade `~/.local/bin` al `PATH` y activa `mise` y `direnv`, necesario para Convoy, versiones declaradas y entornos por repositorio.
- Si no existe `~/.config/lazydocker/config.yml`, se crea desde [`bootstrap/assets/lazydocker/config.yml`](bootstrap/assets/lazydocker/config.yml), configurado para Podman. Si ya existe, el instalador no lo toca y muestra la configuración que hay que fusionar manualmente.

Para actualizar el equipo más adelante, vuelve a ejecutar `./bootstrap/setup-macos.sh`. Los binarios de Homebrew se actualizan con `brew update && brew upgrade`; el script no actualiza masivamente Homebrew para evitar cambios inesperados.

## Añadir otra herramienta

La lista vive en [`bootstrap/catalog.sh`](bootstrap/catalog.sh). Añade una fórmula a `BREW_FORMULAE`, una app a `BREW_CASKS`, o una función `install_*` en [`bootstrap/setup-macos.sh`](bootstrap/setup-macos.sh) si su proveedor usa su propio instalador. Mantén la comprobación `command -v` y una verificación final en `verify_installation`.

No se instalan Docker Desktop, Ollama, un clúster Kubernetes local, frameworks de agentes ni un gestor de secretos concreto: duplicarían LM Studio/Podman o son decisiones de arquitectura y política corporativa que deben quedar por proyecto u organización.
