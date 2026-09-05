# Podman

**Qué resuelve:** construcción y ejecución de contenedores sin un daemon Docker central. En macOS usa una máquina virtual gestionada por Podman.

## Uso diario

```sh
podman machine start
podman info
podman build -t <imagen>:<tag> .
podman run --rm -p 8080:8080 <imagen>:<tag>
podman ps --all
```

No elimines imágenes, volúmenes o máquinas compartidas sin confirmar el objetivo. Usa etiquetas inmutables en artefactos publicados.

## Combinado con

Inspecciona visualmente los contenedores con [LazyDocker](lazydocker.md):

```sh
podman compose up -d
lazydocker
```

Fuente: [Podman Documentation](https://docs.podman.io/).
