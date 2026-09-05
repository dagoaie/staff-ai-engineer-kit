# Cosign

**Qué resuelve:** firma y verificación de imágenes y otros artefactos OCI.

## Política antes de herramienta

Define quién puede firmar, qué identidad se acepta, qué repositorios son confiables y dónde se verifica la firma. Cosign ejecuta la criptografía; la seguridad proviene de que despliegue y CI rechacen artefactos sin una identidad y procedencia válidas.

## Uso diario

```sh
cosign version
cosign sign <registry>/<imagen>@<digest>
cosign verify <registry>/<imagen>@<digest>
cosign verify-attestation <registry>/<imagen>@<digest>
```

Firma por digest, no por tag mutable. Usa la identidad y política de firma de la organización; no inventes claves en el repositorio.

## Combinado con

Publica solo tras análisis de [Trivy](trivy.md) y firma el digest resultante:

```sh
trivy image <registry>/<imagen>@<digest>
cosign sign <registry>/<imagen>@<digest>
```

Fuente: [Sigstore Cosign](https://docs.sigstore.dev/cosign/).
