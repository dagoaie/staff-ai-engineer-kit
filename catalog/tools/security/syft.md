# Syft

**Qué resuelve:** genera un SBOM de una imagen, directorio o archivo.

## Uso diario

```sh
syft <imagen>:<tag>
syft dir:. -o cyclonedx-json > sbom.json
syft <imagen>:<tag> -o spdx-json > sbom.spdx.json
```

Trata el SBOM como artefacto de build: identifica el commit y la imagen que representa.

## Combinado con

Genera un SBOM y pásalo a [Grype](grype.md):

```sh
syft <imagen>:<tag> -o cyclonedx-json > sbom.json
grype sbom:sbom.json
```

Fuente: [Syft Documentation](https://github.com/anchore/syft).
