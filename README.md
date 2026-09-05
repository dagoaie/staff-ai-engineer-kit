# macOS developer setup

Bootstrap reproducible para preparar un Mac nuevo con las herramientas de terminal que uso a diario. El instalador es **idempotente**: se puede volver a ejecutar y solo instala lo que falta o actualiza las herramientas gestionadas por `uv`.

## Uso

```sh
git clone <tu-fork-o-repositorio> ~/code/macos_setup
cd ~/code/macos_setup
./install.sh
```

Por defecto instala las herramientas y configura los ficheros locales, pero no crea ni arranca una máquina virtual de Podman. Para dejar también los contenedores listos:

```sh
./install.sh --start-podman
```

Opciones útiles:

```text
./install.sh --dry-run           # muestra los comandos sin ejecutarlos
./install.sh --skip-skills       # omite el asistente interactivo de Skills
./install.sh --skip-apps         # omite Ghostty y LM Studio
./install.sh --start-podman      # crea/inicia la VM de Podman si hace falta
```

El script debe ejecutarse desde una sesión con Internet. Homebrew puede solicitar la contraseña de macOS durante su propia instalación. Ninguna credencial se escribe en el repositorio.

## Qué instala

| Grupo | Herramientas |
| --- | --- |
| Base y productividad | Homebrew, Zsh, Node.js, `uv`, `jq`, `yq`, Git, Delta, `rg`, `fd`, `fzf`, `bat`, `just`, HTTPie, `btop` |
| Entornos reproducibles | `mise` y `direnv` |
| Contenedores | Podman y LazyDocker, configurado para ejecutar `podman` / `podman compose` |
| Plataforma | `kubectl`, Helm, K9s, Kubectx/Kubens, OpenTofu y TFLint |
| Terminal | Ghostty, Herdr |
| Agentes y protocolos | OpenCode, OpenAI Codex, Convoy, OpenSpec y MCP Inspector |
| Git / cloud | GitLab CLI (`glab`), `glab-tui`, Google Cloud SDK (`gcloud`) |
| LLM local | LM Studio (incluye `lms`) y `llmfit` |
| Calidad y seguridad | Promptfoo, Gitleaks, Trivy, Syft, Grype, Cosign, Semgrep, SOPS y age |
| Skills | El instalador oficial interactivo de Skills for Real Engineers |

## Después de instalar

Abre una terminal nueva (o ejecuta `source ~/.zshrc`) y completa únicamente las autenticaciones que necesitas:

```sh
codex login
gcloud init
glab auth login
opencode
```

`lms` forma parte de la app LM Studio; ábrela una vez antes de usar el CLI. Si se ejecutó con `--start-podman`, comprueba el entorno con `podman info`.

## Flujo base de Staff AI Engineer

El bootstrap instala herramientas; no intenta imponer políticas de cada organización. Esta es la práctica recomendada para convertirlas en un sistema de trabajo:

1. **Entorno por repositorio.** Declara versiones en `mise.toml` y secretos/variables no sensibles en `.envrc`. No añadas secretos a ninguno de los dos ficheros si van a Git; carga referencias mediante 1Password, Vault u otro gestor aprobado.
2. **Evaluaciones como código.** En cada aplicación LLM, guarda corpus, casos adversariales, aserciones y umbrales junto al código. Empieza con `promptfoo init` y ejecútalo en CI antes de variar prompts, modelos, RAG o herramientas.
3. **Seguridad desde el cambio local.** Ejecuta `gitleaks`, `semgrep` y `trivy fs` antes de abrir una MR. Genera un SBOM con `syft` y analiza dependencias/imágenes con `grype` o `trivy`; firma solo los artefactos que lleguen a un registro con `cosign`.
4. **Observabilidad AI.** Toda llamada de producción debería aportar al menos modelo, operación, latencia, tokens, coste, resultado y motivo de fallo a tus trazas. Redacta PII, prompts y outputs antes de exportarlos. Las convenciones GenAI de OpenTelemetry cambian con frecuencia: fija su versión por proyecto y valida cualquier actualización.
5. **MCP con contrato.** Prueba cada servidor MCP localmente con `mcp-inspector`; define autorización, timeout, límites de llamadas, datos que puede exfiltrar y pruebas de regresión para cada herramienta expuesta.
6. **Infraestructura revisable.** Usa OpenTofu/TFLint por repositorio. `kubectl`, Helm y K9s son clientes de los clústeres aprobados; este bootstrap no crea un Kubernetes local porque con Podman no siempre es una necesidad y añade una capa de virtualización evitable.

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
- Si no existe `~/.config/lazydocker/config.yml`, se crea desde [`config/lazydocker/config.yml`](config/lazydocker/config.yml), configurado para Podman. Si ya existe, el instalador no lo toca y muestra la configuración que hay que fusionar manualmente.

Para actualizar el equipo más adelante, vuelve a ejecutar `./install.sh`. Los binarios de Homebrew se actualizan con `brew update && brew upgrade`; el script no actualiza masivamente Homebrew para evitar cambios inesperados.

## Añadir otra herramienta

La lista vive al inicio de [`install.sh`](install.sh). Añade una fórmula a `BREW_FORMULAE`, una app a `BREW_CASKS`, o una función `install_*` si su proveedor usa su propio instalador. Mantén la comprobación `command -v` y una verificación final en `verify_installation`.

No se instalan Docker Desktop, Ollama, un clúster Kubernetes local, frameworks de agentes ni un gestor de secretos concreto: duplicarían LM Studio/Podman o son decisiones de arquitectura y política corporativa que deben quedar por proyecto u organización.
