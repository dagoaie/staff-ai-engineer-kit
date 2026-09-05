# Trivy

**Qué resuelve:** análisis de vulnerabilidades, secretos, configuraciones e imágenes de contenedor.

## Lectura de hallazgos

Prioriza paquetes alcanzables, expuestos y corregibles; una severidad CVSS no es por sí sola el riesgo de tu servicio. Distingue vulnerabilidades de la imagen base, dependencias directas y configuración IaC. Registra una excepción solo con responsable, razón y fecha de revisión.

## Uso diario

```sh
trivy fs .
trivy image <imagen>:<tag>
trivy config .
trivy image --severity HIGH,CRITICAL <imagen>:<tag>
```

Acota severidad y política en CI; no ignores hallazgos sin fecha de revisión y responsable.

## Flujo recomendado

Escanea el árbol antes de construir, la imagen después de construir y el artefacto por digest antes de promoverlo. Usa la misma política en local y CI para evitar sorpresas al abrir una MR.

## Combinado con

Analiza una imagen creada por [Podman](../containers/podman.md):

```sh
podman build -t <imagen>:<tag> .
trivy image <imagen>:<tag>
```

Fuente: [Trivy Documentation](https://trivy.dev/latest/docs/).
