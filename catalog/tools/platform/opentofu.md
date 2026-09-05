# OpenTofu (`tofu`)

**Qué resuelve:** infraestructura como código compatible con el ecosistema Terraform.

## Estado y revisión

El state describe infraestructura real y puede contener datos sensibles. Usa un backend remoto con control de acceso, bloqueo y recuperación aprobados; nunca lo trates como un artefacto local compartible. Un plan debe corresponder al mismo commit, variables y workspace que se aplicará.

## Uso diario

```sh
tofu init
tofu fmt -check
tofu validate
tofu plan -out=tfplan
tofu show tfplan
```

Nunca apliques un plan sin revisarlo ni subas state, planes o credenciales al repositorio.

## Flujo de cambio

Formatea, valida, ejecuta lint, crea un plan legible y haz que otra persona revise cambios de permisos, red, borrados y sustituciones. Recalcula el plan si cambia la rama, el state o la ventana de aplicación.

## Combinado con

Ejecuta [TFLint](tflint.md) antes de crear el plan:

```sh
tflint --init
tflint
tofu plan
```

Fuente: [OpenTofu Documentation](https://opentofu.org/docs/).
