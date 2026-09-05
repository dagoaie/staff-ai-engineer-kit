# LLD: `<componente o cambio>`

El Low-Level Design captura los detalles que harían peligrosa una implementación por interpretación: interfaces, estados, concurrencia, migración, errores y pruebas.

## Diseño

- **Módulos e interfaces:** `<rutas, contratos, tipos>`
- **Estados / secuencia crítica:** `<diagrama o pseudocódigo>`
- **Errores, reintentos, idempotencia y timeouts:** `<…>`
- **Migración y compatibilidad:** `<…>`

## Verificación

| Riesgo | Prueba / señal | Criterio |
| --- | --- | --- |
| `<…>` | `<test, eval, métrica>` | `<umbral>` |

No dupliques el HLD. Enlázalo y limita este documento a decisiones que el implementador necesite ejecutar de forma consistente.
