# Plantilla: presupuesto de coste y latencia

Un presupuesto convierte “este modelo es caro/lento” en una decisión operable. Mide por resultado útil, no solo por llamada.

| Operación | Volumen esperado | Calidad mínima | p95 máximo | Coste por éxito máximo | Degradación |
| --- | ---: | ---: | ---: | ---: | --- |
| `<operación>` | `<día>` | `<score>` | `<ms>` | `<moneda>` | `<fallback>` |

## Suposiciones y alarmas

- Precio/modelo/versiones: `<fecha y fuente>`.
- Tokens de entrada/salida esperados: `<rango>`.
- Alertar si: `<p95, coste, error rate, cuota>` excede `<umbral>` durante `<ventana>`.
- Respuesta al exceso: `<limitar contexto, fallback, cola, desactivar herramienta>`.

Revisa el presupuesto cuando cambien precio, tráfico, prompt, contexto, routing o herramientas. Un ahorro que reduce el scorecard por debajo del mínimo no es una optimización.
