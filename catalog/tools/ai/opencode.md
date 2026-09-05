# OpenCode

**Qué resuelve:** agente de programación en terminal, útil para explorar, implementar y revisar cambios con el proveedor de modelos configurado.

## Modelo de trabajo

OpenCode separa el cliente de los proveedores y modelos que conectes. Úsalo para tareas delimitadas por un contrato de entrada/salida: una incidencia, una especificación o una revisión. Define proveedor, presupuesto y permisos antes de dejar que ejecute comandos.

Una sesión sana empieza con contexto del proyecto y acaba con un diff revisable, no con cambios aplicados a ciegas.

## Uso diario

```sh
cd <repositorio>
opencode
opencode --help
```

Lee el diff antes de aceptar cambios y mantén permisos mínimos. Autentica proveedores mediante su flujo interactivo, nunca pegando claves en archivos versionados.

## Diagnóstico rápido

Si la sesión no usa el modelo o la configuración esperados, revisa el estado desde la propia TUI y el entorno cargado por `direnv`; no corrijas el problema añadiendo claves persistentes a la shell.

## Combinado con

Ejecuta OpenCode dentro de [Herdr](herdr.md) para mantener la sesión al cerrar la terminal:

```sh
cd <repositorio>
herdr
opencode
```

Fuente: [OpenCode Documentation](https://opencode.ai/docs).
