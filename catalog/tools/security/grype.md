# Grype

**Qué resuelve:** análisis de vulnerabilidades de imágenes, directorios y SBOMs.

## Uso diario

```sh
grype <imagen>:<tag>
grype dir:.
grype sbom:sbom.json
grype db status
```

Conserva el resultado junto al artefacto y aplica una política explícita para vulnerabilidades aceptadas temporalmente.

## Combinado con

Escanea el SBOM generado por [Syft](syft.md):

```sh
syft <imagen>:<tag> -o cyclonedx-json > sbom.json
grype sbom:sbom.json
```

Fuente: [Grype Documentation](https://github.com/anchore/grype).
