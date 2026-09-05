# Skills for Real Engineers

**Qué resuelve:** colección de instrucciones reutilizables para que agentes de código apliquen prácticas de ingeniería.

## Alcance

Los skills son instrucciones para el agente, no dependencias de la aplicación. Instálalos en el host de agente elegido y mantenlos separados de las reglas del proyecto. Las reglas propias y permanentes del repositorio siguen perteneciendo a `AGENTS.md`.

## Uso diario

```sh
npx skills@latest add mattpocock/skills
npx skills@latest --help
```

El selector determina qué skills y host instalar. Para Codex, el destino suele estar bajo `~/.codex/skills`; elige solo los que encajen con el flujo y evita duplicar instalaciones.

## Mantenimiento

Cuando actualices o añadas skills, revisa las instrucciones resultantes y sus efectos sobre el flujo del equipo. Instalar un skill no autoriza al agente a saltarse revisión, CI o políticas de seguridad.

## Combinado con

Instala el skill de setup y úsalo al iniciar un repositorio con [OpenSpec](../../tools/ai/openspec.md):

```sh
npx skills@latest add mattpocock/skills
openspec init
```

Fuente: [mattpocock/skills](https://github.com/mattpocock/skills).
