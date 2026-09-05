# TFLint

**Qué resuelve:** lint de Terraform/OpenTofu y reglas específicas de proveedores.

## Qué detecta y qué no

TFLint detecta errores de sintaxis, prácticas y reglas de proveedor, pero no conoce por sí solo el impacto del state ni la política completa de tu organización. Complétalo con `tofu validate`, `tofu plan` y controles de seguridad IaC.

## Uso diario

```sh
tflint --init
tflint
tflint --recursive
tflint --format compact
```

Los plugins se definen por repositorio en `.tflint.hcl`; inicialízalos antes de ejecutar CI local.

## En CI

Fija la configuración y los plugins en el repositorio para que el resultado local y el de CI coincidan. Evita excluir reglas globalmente por un caso aislado; limita la excepción y documenta su fecha de caducidad.

## Combinado con

Valida IaC antes de un plan de [OpenTofu](opentofu.md):

```sh
tofu fmt -check
tflint
tofu validate
```

Fuente: [TFLint](https://github.com/terraform-linters/tflint).
