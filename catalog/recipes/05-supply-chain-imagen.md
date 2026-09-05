# Receta: supply chain de una imagen

Objetivo: construir una imagen trazable, analizarla, generar su SBOM y firmar el artefacto inmutable.

## Identidad del artefacto

Relaciona siempre imagen, digest, commit, origen de la base, SBOM y resultados de análisis. El tag es una etiqueta de conveniencia; el digest es la identidad que puede verificarse y promoverse entre entornos.

## Pasos

Construye y analiza la imagen local:

```sh
podman build -t <imagen>:<tag> .
trivy image --severity HIGH,CRITICAL <imagen>:<tag>
```

Genera y escanea el SBOM:

```sh
syft <imagen>:<tag> -o cyclonedx-json > sbom.json
grype sbom:sbom.json
```

Tras publicar y obtener el digest, firma y verifica el artefacto:

```sh
cosign sign <registry>/<imagen>@<digest>
cosign verify <registry>/<imagen>@<digest>
```

## Criterio de promoción

Promueve únicamente si la política de vulnerabilidades se cumple, el SBOM se ha conservado y la firma se verifica con la identidad esperada. Si hay una excepción, debe ser explícita, temporal y revisable.

## Guardrails

- Promueve imágenes por digest, no por tags mutables como `latest`.
- Conserva SBOM, resultados y referencia del commit como artefactos CI.
- La política de severidad, excepciones y firma pertenece al repositorio y a la organización.

Herramientas: [Podman](../tools/containers/podman.md), [Trivy](../tools/security/trivy.md), [Syft](../tools/security/syft.md), [Grype](../tools/security/grype.md), [Cosign](../tools/security/cosign.md).
