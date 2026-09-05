#!/usr/bin/env bash
# Declarative inventory consumed by setup-macos.sh. Do not execute directly.

# Global baseline for the personal toolkit. Project-specific dependencies such
# as DeepEval and Docling deliberately stay out of this inventory.
BREW_FORMULAE=(
  zsh node uv jq yq
  git git-delta ripgrep fd fzf bat glow just httpie btop duckdb d2
  adr-tools markdownlint-cli2 lychee
  mise direnv
  podman lazydocker
  kubectl helm k9s kubectx opentofu stern
  gitleaks trivy syft grype cosign semgrep sops age
  glab glab-tui herdr codex promptfoo
)

# Vendor CLIs are casks; GUI applications remain separately skippable.
BREW_CASKS=(google-cloud-sdk 1password-cli)
BREW_APP_CASKS=(ghostty lm-studio 1password)

category_for_formula() {
  case "$1" in
    zsh|node|uv|jq|yq|git) printf 'base' ;;
    git-delta|ripgrep|fd|fzf|bat|glow|just|httpie|btop|duckdb|d2|adr-tools|markdownlint-cli2|lychee) printf 'productivity' ;;
    mise|direnv) printf 'environment' ;;
    podman|lazydocker) printf 'containers' ;;
    kubectl|helm|k9s|kubectx|opentofu|stern) printf 'platform' ;;
    gitleaks|trivy|syft|grype|cosign|semgrep|sops|age|1password-cli) printf 'security' ;;
    glab|glab-tui) printf 'collaboration' ;;
    herdr|codex|promptfoo|opencode|convoy|openspec|mcp-inspector) printf 'agents' ;;
    lm-studio|llmfit|lms) printf 'local-llm' ;;
    ghostty) printf 'terminal' ;;
    google-cloud-sdk|gcloud|tflint) printf 'platform' ;;
    1password|op|security|ssh|ssh-keygen|ssh-add) printf 'security' ;;
    *) printf 'base' ;;
  esac
}

category_for_selection() {
  local normalized
  normalized="$(printf '%s' "$1" | tr '[:upper:]' '[:lower:]' | tr -cs '[:alnum:]' '-')"
  normalized="${normalized#-}"
  normalized="${normalized%-}"
  case "$normalized" in
    base|homebrew|zsh|node|nodejs|uv|jq|yq|git) printf 'base' ;;
    productivity|delta|ripgrep|rg|fd|fzf|bat|glow|just|httpie|btop|duckdb|d2|adr|adr-tools|markdownlint|markdownlint-cli2|lychee) printf 'productivity' ;;
    environment|entornos|mise|direnv) printf 'environment' ;;
    containers|contenedores|podman|lazydocker) printf 'containers' ;;
    platform|plataforma|gcloud|google-cloud-sdk|kubectl|helm|k9s|kubectx|opentofu|tofu|tflint|stern) printf 'platform' ;;
    security|seguridad|1password|1password-cli|op|sops|age|gitleaks|trivy|syft|grype|cosign|semgrep|ssh|keychain) printf 'security' ;;
    collaboration|colaboracion|glab|glab-tui) printf 'collaboration' ;;
    agents|agentes|ai|codex|opencode|herdr|convoy|openspec|mcp-inspector|promptfoo|skills) printf 'agents' ;;
    local-llm|llm-local|lm-studio|lms|llmfit) printf 'local-llm' ;;
    terminal|ghostty) printf 'terminal' ;;
    all|todo|todas) printf 'all' ;;
    *) return 1 ;;
  esac
}
