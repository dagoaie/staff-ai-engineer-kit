# LazyDocker

**Qué resuelve:** interfaz terminal para inspeccionar logs, imágenes, redes y contenedores. Este setup lo configura para ejecutar `podman` y `podman compose`.

## Uso diario

```sh
lazydocker
podman ps
podman logs <contenedor>
```

Las acciones de borrar o parar son reales: confirma nombre, proyecto y entorno antes de aceptarlas.

## Combinado con

Depura un servicio de evaluación local y consulta su healthcheck con [HTTPie](../productivity/httpie.md):

```sh
lazydocker
http GET http://localhost:8080/health
```

Fuente: [LazyDocker](https://github.com/jesseduffield/lazydocker).
