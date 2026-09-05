# Biblioteca de herramientas

Guías operativas para el toolkit instalado por este repositorio. Cada ficha explica el propósito, comandos de partida, límites e integración con otras herramientas. Los comandos usan marcadores como `<PROJECT_ID>` y nunca deben recibir secretos literales.

Antes de instalar, ejecuta `./bootstrap/setup-macos.sh --status` desde la raíz para auditar el equipo. El resultado sugiere un `--only <categorías>` o puedes usar `./bootstrap/setup-macos.sh --select` para elegirlas de forma interactiva. También acepta una selección directa por herramienta o categoría: `./bootstrap/setup-macos.sh --select "1Password CLI"` instala el grupo `security`.

Comprueba enlaces locales y, si están instalados, estilo/enlaces externos con `./tests/docs-check.sh`.

## Fundamentos y entorno

- [Homebrew](tools/fundamentals/homebrew.md), [Zsh](tools/fundamentals/zsh.md), [Ghostty](tools/fundamentals/ghostty.md), [Node.js](tools/fundamentals/nodejs.md), [uv](tools/fundamentals/uv.md), [mise](tools/fundamentals/mise.md), [direnv](tools/fundamentals/direnv.md)

## Productividad

- [jq](tools/productivity/jq.md), [yq](tools/productivity/yq.md), [Git](tools/productivity/git.md), [Delta](tools/productivity/delta.md), [ripgrep](tools/productivity/ripgrep.md), [fd](tools/productivity/fd.md), [fzf](tools/productivity/fzf.md), [bat](tools/productivity/bat.md), [Glow](tools/productivity/glow.md), [just](tools/productivity/just.md), [HTTPie](tools/productivity/httpie.md), [btop](tools/productivity/btop.md), [DuckDB](tools/productivity/duckdb.md), [D2](tools/productivity/d2.md), [adr-tools](tools/productivity/adr-tools.md), [markdownlint-cli2](tools/productivity/markdownlint-cli2.md), [Lychee](tools/productivity/lychee.md)

## Contenedores, plataforma e IaC

- [Podman](tools/containers/podman.md), [LazyDocker](tools/containers/lazydocker.md)
- [Google Cloud SDK](tools/platform/gcloud.md), [kubectl](tools/platform/kubectl.md), [Helm](tools/platform/helm.md), [K9s](tools/platform/k9s.md), [kubectx](tools/platform/kubectx.md), [OpenTofu](tools/platform/opentofu.md), [TFLint](tools/platform/tflint.md), [Stern](tools/platform/stern.md)

## Seguridad

- [Gitleaks](tools/security/gitleaks.md), [Trivy](tools/security/trivy.md), [Syft](tools/security/syft.md), [Grype](tools/security/grype.md), [Cosign](tools/security/cosign.md), [Semgrep](tools/security/semgrep.md), [SOPS](tools/security/sops.md), [age](tools/security/age.md), [1Password CLI](tools/security/onepassword-cli.md), [Keychain CLI](tools/security/macos-keychain.md) y [OpenSSH](tools/security/ssh.md)

## Agentes y AI

- [OpenCode](tools/ai/opencode.md), [Codex](tools/ai/codex.md), [Herdr](tools/ai/herdr.md), [Convoy](tools/ai/convoy.md), [OpenSpec](tools/ai/openspec.md), [MCP Inspector](tools/ai/mcp-inspector.md), [Promptfoo](tools/ai/promptfoo.md), [DeepEval](tools/ai/deepeval.md), [Docling](tools/ai/docling.md)

## Extensiones de agente

[Skills y MCP](agent-extensions/README.md) no son herramientas intercambiables: las skills escalan criterio del agente; MCP escala sus capacidades y, por tanto, su superficie de riesgo.

## LLM local y colaboración

- [LM Studio](tools/local-llm/lm-studio.md), [`lms`](tools/local-llm/lms.md), [llmfit](tools/local-llm/llmfit.md)
- [glab](tools/collaboration/glab.md), [glab-tui](tools/collaboration/glab-tui.md)

## Recetas Staff AI

1. [Repositorio reproducible](recipes/01-repositorio-reproducible.md)
2. [Entorno AI local](recipes/02-entorno-ai-local.md)
3. [Evaluar un cambio AI](recipes/03-evaluar-cambio-ai.md)
4. [Desarrollar y validar MCP](recipes/04-desarrollar-mcp.md)
5. [Supply chain de una imagen](recipes/05-supply-chain-imagen.md)
6. [Desplegar y operar en GCP/Kubernetes](recipes/06-gcp-kubernetes.md)
7. [Gestionar secretos e identidades](recipes/07-secretos-e-identidades.md)
8. [Documentos a RAG evaluable](recipes/08-documentos-a-rag.md)

## Staff AI operating system

[Plantillas y plan de 90 días](../playbook/README.md) para pasar de la ejecución individual a una práctica Staff: mapa de sistemas, política de routing, scorecard de evaluaciones, límites MCP, contrato de telemetría, presupuestos y decisiones arquitectónicas. La [matriz de decisión documental](../playbook/documentation-decision-matrix.md) conecta PRD, RFC, HLD, FDD, LLD, ADR y fichas AI con cada tipo de cambio.
