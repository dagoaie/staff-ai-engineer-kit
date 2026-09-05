# OpenAI Codex

**Qué resuelve:** agente de programación de OpenAI para trabajar en repositorios desde terminal.

## Modelo de trabajo

Codex es más útil cuando el repositorio ya expresa sus convenciones: `AGENTS.md`, tests rápidos y comandos de verificación. Dale una tarea con resultado verificable, límites explícitos y el comando que debe ejecutar al terminar. No lo uses como sustituto de una decisión de arquitectura o de una aprobación de producción.

Antes de empezar, comprueba que estás en el repositorio correcto y que no hay cambios ajenos que pueda confundir:

```sh
git status --short
rg --files -g 'AGENTS.md' -g 'README.md' -g 'justfile'
```

## Uso diario

```sh
codex login
cd <repositorio>
codex
codex --help
```

Define el alcance de cada tarea, revisa el diff y ejecuta las pruebas antes de confirmar. No concedas permisos amplios sin entender el comando propuesto.

## Cierre de una sesión

Pide siempre evidencia concreta: diff, pruebas ejecutadas y limitaciones conocidas. Después valida por tu cuenta el árbol de trabajo y los controles de seguridad:

```sh
git diff --check
just check
git status --short
```

## Combinado con

Pide una implementación y revisa su resultado con [Delta](../productivity/delta.md):

```sh
codex
git diff | delta
```

Fuente: [Codex CLI](https://developers.openai.com/codex/cli/).
