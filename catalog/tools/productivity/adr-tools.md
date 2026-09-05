# adr-tools

`adr-tools` crea y mantiene *Architecture Decision Records* desde terminal. Un ADR registra una decisión técnica que seguirá importando cuando la issue, la MR o las personas que la tomaron ya no estén activas.

## Uso diario

Inicializa el directorio de decisiones en el repositorio y crea una decisión:

```sh
adr init docs/decisions
adr new --adr-dir docs/decisions "Adoptar routing por complejidad"
adr list --adr-dir docs/decisions
```

Un ADR debe contener contexto, decisión, alternativas, consecuencias, owner y un disparador de revisión. No lo uses para registrar cada detalle de implementación: esos pertenecen al diseño del cambio.

## Combinado con

- [OpenSpec](../ai/openspec.md): enlaza ADRs relevantes desde el `proposal` y el `design` de cambios que los ejecuten.
- [D2](d2.md): representa el sistema o el flujo que queda afectado por la decisión.
- [Promptfoo](../ai/promptfoo.md): una decisión de modelo/routing debe enlazar al scorecard que prueba sus consecuencias.

## Referencias

- [adr-tools](https://github.com/npryce/adr-tools)
- [Plantilla ADR del playbook](../../../playbook/adr-template.md)
