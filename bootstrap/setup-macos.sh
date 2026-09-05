#!/usr/bin/env bash
# Reproducible bootstrap for a developer Mac. Safe to run more than once.
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ZSHRC="${HOME}/.zshrc"
readonly LOCAL_BIN="${HOME}/.local/bin"
readonly LAZYDOCKER_CONFIG_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}/lazydocker"
readonly LAZYDOCKER_CONFIG="${LAZYDOCKER_CONFIG_DIR}/config.yml"

DRY_RUN=false
START_PODMAN=false
SKIP_SKILLS=false
SKIP_APPS=false
STATUS_ONLY=false
SELECT_CATEGORIES=false
SELECT_QUERY=""
ONLY_CATEGORIES=""

source "$SCRIPT_DIR/catalog.sh"

usage() {
  cat <<'EOF'
Usage: ./bootstrap/setup-macos.sh [options]

  --dry-run        Print actions without changing the machine
  --start-podman   Create and start the default Podman machine
  --skip-skills    Do not run the interactive Skills for Real Engineers installer
  --skip-apps      Do not install Ghostty or LM Studio
  --status         Audit installed tools and suggest missing categories; makes no changes
  --select [name]  Interactively choose categories, or select one by tool/category name
  --only <list>    Install comma-separated categories (for example: agents,security)
  -h, --help       Show this help
EOF
}

log() { printf '\n==> %s\n' "$*"; }
warn() { printf '\nWARNING: %s\n' "$*" >&2; }

run() {
  if "$DRY_RUN"; then
    printf '[dry-run]'; printf ' %q' "$@"; printf '\n'
  else
    "$@"
  fi
}

should_install() {
  local category="$1"
  [[ -z "$ONLY_CATEGORIES" || "$ONLY_CATEGORIES" == "all" || " $ONLY_CATEGORIES " == *" $category "* ]]
}

validate_categories() {
  local category
  for category in ${ONLY_CATEGORIES//,/ }; do
    case "$category" in
      base|productivity|environment|containers|platform|security|collaboration|agents|local-llm|terminal|all) ;;
      *) warn "Categoría desconocida: $category"; exit 2 ;;
    esac
  done
  ONLY_CATEGORIES="${ONLY_CATEGORIES//,/ }"
}

toggle_category() {
  local category="$1"
  if [[ " $ONLY_CATEGORIES " == *" $category "* ]]; then
    ONLY_CATEGORIES="${ONLY_CATEGORIES/$category/}"
  else
    ONLY_CATEGORIES="$ONLY_CATEGORIES $category"
  fi
}

choose_categories() {
  local choice
  while true; do
    printf '\nCategorías seleccionadas:%s\n' "${ONLY_CATEGORIES:- ninguna}"
    cat <<'EOF'
  1) base            6) seguridad
  2) productividad   7) colaboración
  3) entornos        8) agentes AI
  4) contenedores    9) LLM local
  5) plataforma     10) terminal
  a) todas           i) instalar selección   q) salir
EOF
    read -r -p 'Elige una opción: ' choice
    case "$choice" in
      1) toggle_category base ;;
      2) toggle_category productivity ;;
      3) toggle_category environment ;;
      4) toggle_category containers ;;
      5) toggle_category platform ;;
      6) toggle_category security ;;
      7) toggle_category collaboration ;;
      8) toggle_category agents ;;
      9) toggle_category local-llm ;;
      10) toggle_category terminal ;;
      a|A) ONLY_CATEGORIES=all; return ;;
      i|I)
        if [[ -n "${ONLY_CATEGORIES// /}" ]]; then return; fi
        warn 'Selecciona al menos una categoría.'
        ;;
      q|Q) printf 'Sin cambios.\n'; exit 0 ;;
      *) warn 'Opción no válida.' ;;
    esac
  done
}

while (($#)); do
  case "$1" in
    --dry-run) DRY_RUN=true ;;
    --start-podman) START_PODMAN=true ;;
    --skip-skills) SKIP_SKILLS=true ;;
    --skip-apps) SKIP_APPS=true ;;
    --status) STATUS_ONLY=true ;;
    --select)
      SELECT_CATEGORIES=true
      shift
      while (($#)) && [[ "$1" != --* ]]; do
        SELECT_QUERY+="${SELECT_QUERY:+ }$1"
        shift
      done
      continue
      ;;
    --only)
      if (($# < 2)); then warn '--only necesita una lista de categorías.'; exit 2; fi
      ONLY_CATEGORIES="$2"
      shift
      ;;
    -h|--help) usage; exit 0 ;;
    *) warn "Opción desconocida: $1"; usage >&2; exit 2 ;;
  esac
  shift
done

require_macos() {
  if [[ "$(uname -s)" != "Darwin" ]]; then
    printf 'Este bootstrap está pensado para macOS.\n' >&2
    exit 1
  fi
}

install_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    return
  fi

  log 'Instalando Homebrew'
  if "$DRY_RUN"; then
    printf '[dry-run] instalar Homebrew desde https://brew.sh\n'
    return
  fi
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

load_brew() {
  if command -v brew >/dev/null 2>&1; then
    return
  fi

  local brew_path
  for brew_path in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [[ -x "$brew_path" ]]; then
      eval "$("$brew_path" shellenv)"
      return
    fi
  done
  printf 'No se encontró Homebrew tras la instalación. Abre una terminal nueva e inténtalo de nuevo.\n' >&2
  exit 1
}

install_brew_packages() {
  local formula category
  log 'Instalando fórmulas de Homebrew'
  for formula in "${BREW_FORMULAE[@]}"; do
    category="$(category_for_formula "$formula")"
    should_install "$category" || continue
    if brew list --formula "$formula" >/dev/null 2>&1; then
      printf '  ✓ %s\n' "$formula"
    else
      run brew install "$formula"
    fi
  done

  log 'Instalando herramientas distribuidas como cask'
  for formula in "${BREW_CASKS[@]}"; do
    category="$(category_for_formula "$formula")"
    should_install "$category" || continue
    if brew list --cask "$formula" >/dev/null 2>&1; then
      printf '  ✓ %s\n' "$formula"
    else
      run brew install --cask "$formula"
    fi
  done

  if "$SKIP_APPS"; then
    return
  fi
  log 'Instalando aplicaciones de Homebrew'
  for formula in "${BREW_APP_CASKS[@]}"; do
    category="$(category_for_formula "$formula")"
    should_install "$category" || continue
    if brew list --cask "$formula" >/dev/null 2>&1; then
      printf '  ✓ %s\n' "$formula"
    else
      run brew install --cask "$formula"
    fi
  done
}

install_opencode() {
  if command -v opencode >/dev/null 2>&1; then
    printf '  ✓ opencode\n'
    return
  fi
  log 'Instalando OpenCode'
  run brew install anomalyco/tap/opencode
}

install_convoy() {
  if command -v convoy >/dev/null 2>&1; then
    printf '  ✓ convoy\n'
    return
  fi
  log 'Instalando Convoy'
  run mkdir -p "$LOCAL_BIN"
  if "$DRY_RUN"; then
    printf '[dry-run] descargar y ejecutar instalador oficial de Convoy\n'
    return
  fi

  local installer
  installer="$(mktemp -t convoy-install.XXXXXX)"
  trap 'rm -f "$installer"' RETURN
  curl -fsSL https://github.com/Inakitajes/convoy/releases/latest/download/install.sh -o "$installer"
  CONVOY_INSTALL_DIR="$LOCAL_BIN" sh "$installer"
  rm -f "$installer"
  trap - RETURN
}

install_openspec() {
  if command -v openspec >/dev/null 2>&1; then
    printf '  ✓ openspec\n'
    return
  fi
  log 'Instalando OpenSpec'
  run npm install --global @fission-ai/openspec@latest
}

install_tflint() {
  if command -v tflint >/dev/null 2>&1; then
    printf '  ✓ tflint\n'
    return
  fi
  log 'Instalando TFLint'
  run brew install terraform-linters/tap/tflint
}

install_mcp_inspector() {
  if command -v mcp-inspector >/dev/null 2>&1; then
    printf '  ✓ mcp-inspector\n'
    return
  fi
  log 'Instalando MCP Inspector'
  run npm install --global @modelcontextprotocol/inspector
}

install_llmfit() {
  if command -v llmfit >/dev/null 2>&1; then
    printf '  ✓ llmfit\n'
    return
  fi
  log 'Instalando llmfit'
  run uv tool install --upgrade llmfit
}

install_skills() {
  if "$SKIP_SKILLS"; then
    return
  fi
  log 'Instalando Skills for Real Engineers'
  printf 'Se abrirá el selector oficial; elige los skills y el host de agente.\n'
  run npx skills@latest add mattpocock/skills
}

status_item() {
  local category="$1"
  local command_name="$2"
  local label="${3:-$2}"
  if command -v "$command_name" >/dev/null 2>&1; then
    printf '  ✓ %-18s %s\n' "$label" "$category"
  else
    printf '  ! %-18s %s\n' "$label" "$category"
    MISSING_CATEGORIES="$MISSING_CATEGORIES $category"
  fi
}

print_status() {
  log 'Estado del toolkit (✓ instalado, ! pendiente)'
  MISSING_CATEGORIES=""
  status_item base brew Homebrew
  status_item base zsh Zsh
  status_item base node Node.js
  status_item base uv uv
  status_item base jq jq
  status_item base yq yq
  status_item base git Git
  status_item productivity delta Delta
  status_item productivity rg ripgrep
  status_item productivity fd fd
  status_item productivity fzf fzf
  status_item productivity bat bat
  status_item productivity glow Glow
  status_item productivity just just
  status_item productivity http HTTPie
  status_item productivity btop btop
  status_item productivity duckdb DuckDB
  status_item productivity d2 D2
  status_item productivity adr adr-tools
  status_item productivity markdownlint-cli2 markdownlint-cli2
  status_item productivity lychee Lychee
  status_item environment mise mise
  status_item environment direnv direnv
  status_item containers podman Podman
  status_item containers lazydocker LazyDocker
  status_item platform gcloud gcloud
  status_item platform kubectl kubectl
  status_item platform helm Helm
  status_item platform k9s K9s
  status_item platform kubectx kubectx
  status_item platform tofu OpenTofu
  status_item platform tflint TFLint
  status_item platform stern Stern
  status_item security op '1Password CLI'
  status_item security sops SOPS
  status_item security trivy Trivy
  status_item security gitleaks Gitleaks
  status_item security syft Syft
  status_item security grype Grype
  status_item security cosign Cosign
  status_item security semgrep Semgrep
  status_item security age age
  status_item agents codex Codex
  status_item agents opencode OpenCode
  status_item agents herdr Herdr
  status_item agents promptfoo Promptfoo
  status_item agents mcp-inspector 'MCP Inspector'
  status_item agents convoy Convoy
  status_item agents openspec OpenSpec
  status_item local-llm lms lms
  status_item local-llm llmfit llmfit
  status_item collaboration glab glab
  status_item collaboration glab-tui glab-tui
  status_item terminal ghostty Ghostty

  if [[ -n "${MISSING_CATEGORIES// /}" ]]; then
    local -a unique=()
    local category
    for category in $MISSING_CATEGORIES; do
      case " ${unique[*]-} " in *" $category "*) ;; *) unique+=("$category") ;; esac
    done
    printf '\nPara instalar solo las categorías pendientes:\n  ./bootstrap/setup-macos.sh --only %s\n' "$(IFS=,; printf '%s' "${unique[*]}")"
    printf 'O abre el selector con:\n  ./bootstrap/setup-macos.sh --select\n'
  else
    printf '\nTodo el toolkit está disponible en PATH.\n'
  fi
}

configure_zsh() {
  log 'Configurando Zsh'
  local begin='# >>> macos_setup >>>'
  local end='# <<< macos_setup <<<'
  local block
  block="$begin
# Binarios de instaladores de usuario (Convoy y similares).
export PATH=\"\$HOME/.local/bin:\$PATH\"

# Entornos y versiones declarados por cada repositorio.
if command -v mise >/dev/null 2>&1; then
  eval \"\$(mise activate zsh)\"
fi
if command -v direnv >/dev/null 2>&1; then
  eval \"\$(direnv hook zsh)\"
fi
$end"

  if [[ -f "$ZSHRC" ]] && grep -Fqx "$begin" "$ZSHRC"; then
    printf '  ✓ bloque macos_setup ya presente en %s\n' "$ZSHRC"
  elif "$DRY_RUN"; then
    printf '[dry-run] añadir PATH gestionado a %s\n' "$ZSHRC"
  else
    touch "$ZSHRC"
    printf '\n%s\n' "$block" >> "$ZSHRC"
  fi
}

configure_lazydocker() {
  log 'Configurando LazyDocker para Podman'
  if [[ -e "$LAZYDOCKER_CONFIG" ]]; then
    warn "$LAZYDOCKER_CONFIG ya existe; no se sobrescribe. Asegúrate de incluir commandTemplates para podman."
    return
  fi
  run mkdir -p "$LAZYDOCKER_CONFIG_DIR"
  run cp "$SCRIPT_DIR/assets/lazydocker/config.yml" "$LAZYDOCKER_CONFIG"
}

configure_podman() {
  if ! "$START_PODMAN"; then
    return
  fi
  log 'Preparando la máquina de Podman'
  if podman machine inspect >/dev/null 2>&1; then
    printf '  ✓ máquina de Podman ya creada\n'
  else
    run podman machine init
  fi
  if podman machine inspect --format '{{.State}}' 2>/dev/null | grep -qx 'running'; then
    printf '  ✓ máquina de Podman ya está en ejecución\n'
  else
    run podman machine start
  fi
}

verify_installation() {
  log 'Verificación'
  if "$DRY_RUN"; then
    printf '  Se omite la verificación de binarios durante --dry-run.\n'
    return
  fi
  local command_name
  local -a commands=(
    zsh node uv jq yq git delta rg fd fzf bat glow just http btop duckdb d2 adr markdownlint-cli2 lychee mise direnv
    podman lazydocker kubectl helm k9s kubectx tofu tflint stern
    gitleaks trivy syft grype cosign semgrep sops age op security ssh ssh-keygen ssh-add
    opencode codex herdr convoy openspec mcp-inspector promptfoo
    gcloud llmfit lms glab glab-tui brew
  )
  for command_name in "${commands[@]}"; do
    if [[ "$command_name" != "brew" ]] && ! should_install "$(category_for_formula "$command_name")"; then
      continue
    fi
    if command -v "$command_name" >/dev/null 2>&1; then
      printf '  ✓ %s\n' "$command_name"
    else
      printf '  ! %s (no está aún en PATH; abre una terminal nueva)\n' "$command_name"
    fi
  done
}

main() {
  require_macos
  if "$STATUS_ONLY"; then
    print_status
    return
  fi
  if "$SELECT_CATEGORIES"; then
    if [[ -n "$SELECT_QUERY" ]]; then
      if ! ONLY_CATEGORIES="$(category_for_selection "$SELECT_QUERY")"; then
        warn "No reconozco la herramienta o categoría: $SELECT_QUERY"
        printf 'Prueba con una categoría (por ejemplo, security) o una herramienta (por ejemplo, "1Password CLI").\n' >&2
        exit 2
      fi
      printf 'Selección directa: %s → %s\n' "$SELECT_QUERY" "$ONLY_CATEGORIES"
    else
      choose_categories
    fi
  fi
  if [[ -n "$ONLY_CATEGORIES" ]]; then
    validate_categories
  fi
  install_homebrew
  load_brew
  install_brew_packages
  if should_install agents; then
    install_opencode
    install_convoy
    install_openspec
    install_mcp_inspector
    install_skills
  fi
  if should_install platform; then install_tflint; fi
  if should_install local-llm; then install_llmfit; fi
  if should_install base || should_install environment || should_install agents; then configure_zsh; fi
  if should_install containers; then
    configure_lazydocker
    configure_podman
  fi
  verify_installation
  log 'Terminado'
  printf 'Abre una terminal nueva y ejecuta: codex login, gcloud init y glab auth login.\n'
}

main "$@"
