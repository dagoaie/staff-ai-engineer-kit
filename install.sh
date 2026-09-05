#!/usr/bin/env bash
# Reproducible bootstrap for a developer Mac. Safe to run more than once.
set -euo pipefail

readonly PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ZSHRC="${HOME}/.zshrc"
readonly LOCAL_BIN="${HOME}/.local/bin"
readonly LAZYDOCKER_CONFIG_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}/lazydocker"
readonly LAZYDOCKER_CONFIG="${LAZYDOCKER_CONFIG_DIR}/config.yml"

DRY_RUN=false
START_PODMAN=false
SKIP_SKILLS=false
SKIP_APPS=false

# Keep this declarative list as the inventory grows.
# They are intentionally global: this repository is the baseline for a Staff AI
# Engineer, not a collection of optional profiles.
BREW_FORMULAE=(
  zsh node uv jq yq
  git git-delta ripgrep fd fzf bat just httpie btop
  mise direnv
  podman lazydocker
  kubectl helm k9s kubectx opentofu
  gitleaks trivy syft grype cosign semgrep sops age
  glab glab-tui herdr codex promptfoo
)
BREW_CASKS=(ghostty google-cloud-sdk lm-studio)

usage() {
  cat <<'EOF'
Usage: ./install.sh [options]

  --dry-run        Print actions without changing the machine
  --start-podman   Create and start the default Podman machine
  --skip-skills    Do not run the interactive Skills for Real Engineers installer
  --skip-apps      Do not install Ghostty or LM Studio
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

while (($#)); do
  case "$1" in
    --dry-run) DRY_RUN=true ;;
    --start-podman) START_PODMAN=true ;;
    --skip-skills) SKIP_SKILLS=true ;;
    --skip-apps) SKIP_APPS=true ;;
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
  local formula
  log 'Instalando fórmulas de Homebrew'
  for formula in "${BREW_FORMULAE[@]}"; do
    if brew list --formula "$formula" >/dev/null 2>&1; then
      printf '  ✓ %s\n' "$formula"
    else
      run brew install "$formula"
    fi
  done

  if "$SKIP_APPS"; then
    return
  fi
  log 'Instalando aplicaciones de Homebrew'
  for formula in "${BREW_CASKS[@]}"; do
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
  run cp "$PROJECT_DIR/config/lazydocker/config.yml" "$LAZYDOCKER_CONFIG"
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
    zsh node uv jq yq git delta rg fd fzf bat just http btop mise direnv
    podman lazydocker kubectl helm k9s kubectx tofu tflint
    gitleaks trivy syft grype cosign semgrep sops age
    opencode codex herdr convoy openspec mcp-inspector promptfoo
    gcloud llmfit lms glab glab-tui brew
  )
  for command_name in "${commands[@]}"; do
    if command -v "$command_name" >/dev/null 2>&1; then
      printf '  ✓ %s\n' "$command_name"
    else
      printf '  ! %s (no está aún en PATH; abre una terminal nueva)\n' "$command_name"
    fi
  done
}

main() {
  require_macos
  install_homebrew
  load_brew
  install_brew_packages
  install_opencode
  install_convoy
  install_openspec
  install_tflint
  install_mcp_inspector
  install_llmfit
  configure_zsh
  configure_lazydocker
  configure_podman
  install_skills
  verify_installation
  log 'Terminado'
  printf 'Abre una terminal nueva y ejecuta: codex login, gcloud init y glab auth login.\n'
}

main "$@"
