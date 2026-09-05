# Semgrep

**Qué resuelve:** análisis estático configurable para detectar patrones de seguridad y calidad.

## Uso diario

```sh
semgrep scan --config auto
semgrep scan --config p/security-audit .
semgrep scan --config <regla-o-directorio>
```

Revisa el contexto de cada hallazgo y mantén reglas propias versionadas. No envíes código sensible a servicios externos sin aprobación.

## Combinado con

Ejecuta comprobaciones locales con [Gitleaks](gitleaks.md):

```sh
gitleaks detect --source .
semgrep scan --config auto
```

Fuente: [Semgrep Documentation](https://semgrep.dev/docs/).
