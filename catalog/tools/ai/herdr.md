# Herdr

**Qué resuelve:** multiplexer persistente para terminales y agentes, con panes, sesiones y detección de estado.

## Cuándo usarlo

Úsalo cuando una tarea de agente dure más que una terminal, necesites observar varias ejecuciones o quieras conservar contexto al desconectarte. Para un comando corto, una shell normal es más simple. Herdr organiza procesos; no aísla permisos ni reemplaza control de acceso.

## Uso diario

```sh
cd <repositorio>
herdr
herdr --help
herdr agent list
```

Abre una sesión por proyecto y no cierres panes ajenos. Usa el CLI de Herdr dentro de una sesión gestionada para automatizar panes o agentes.

## Operación segura

Nombra agentes según su función (`implementer`, `reviewer`) y conserva el foco en tu pane al crear trabajo de fondo. Antes de enviar instrucciones a un agente, comprueba si está esperando una aprobación o una pregunta.

## Combinado con

Ejecuta [Codex](codex.md) en una sesión persistente:

```sh
cd <repositorio>
herdr
codex
```

Fuente: [Herdr Documentation](https://herdr.dev/docs/).
