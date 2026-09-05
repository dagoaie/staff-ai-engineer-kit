# Gitleaks

**Qué resuelve:** detección de secretos expuestos en el árbol de trabajo y el historial Git.

## Respuesta a una filtración

1. Revoca o rota la credencial en el proveedor.
2. Evalúa accesos desde el momento de exposición.
3. Elimina el secreto del árbol y del historial según el procedimiento del equipo.
4. Añade una regla o control que evite la recurrencia.

## Uso diario

```sh
gitleaks detect --source .
gitleaks git --log-opts="-n 50"
gitleaks detect --redact --source .
```

Un hallazgo requiere revocar o rotar la credencial: borrar la línea no elimina una filtración previa. Las excepciones deben estar justificadas y versionadas.

## Combinado con

Inclúyelo en una tarea [just](../productivity/just.md) antes de una MR:

```sh
just check
gitleaks detect --source .
```

Fuente: [Gitleaks](https://github.com/gitleaks/gitleaks).
