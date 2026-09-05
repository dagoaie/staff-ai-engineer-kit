# Plantilla: contrato de telemetría AI

Instrumenta para operar y tomar decisiones, no para capturar conversaciones. Alinea los nombres con la versión de convenciones de OpenTelemetry que el proyecto haya fijado; las convenciones GenAI evolucionan.

## Señales mínimas por operación

| Señal | Ejemplos | Regla de privacidad |
| --- | --- | --- |
| Identidad técnica | `service`, `environment`, `deployment` | sin identificadores personales |
| Ruta AI | operación, proveedor, modelo, versión | no incluir prompt completo |
| Rendimiento | latencia total, TTFT, p95, timeout | agregar cuando baste |
| Uso y coste | tokens entrada/salida, coste estimado | no incluir contenido |
| Resultado | éxito, error clasificado, evaluación | usar IDs de correlación |
| Herramientas | nombre, permiso, duración, resultado | no registrar argumentos sensibles |

## Retención y acceso

- **Redacción antes de exportar:** `<campos, método, owner>`.
- **Retención:** `<duración y justificación>`.
- **Acceso:** `<roles, auditoría>`.
- **Muestreo:** `<regla>`; los errores importantes no dependen solo de muestreo aleatorio.
- **Enlace a incidentes:** `<trace_id/request_id>` en vez de copiar contenido a tickets.

Referencia: [OpenTelemetry Semantic Conventions](https://opentelemetry.io/docs/specs/semconv/).
