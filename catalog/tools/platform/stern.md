# Stern

Stern sigue logs de varios pods de Kubernetes a la vez y etiqueta cada línea por pod y contenedor. Para un sistema AI distribuido es más eficiente que alternar manualmente entre réplicas cuando investigas una degradación, timeout o error de herramientas.

## Uso diario

Seguir los pods de una aplicación por etiqueta, con contexto acotado:

```sh
stern -n <namespace> -l app=<app> --tail 50
```

Filtrar errores de una operación concreta:

```sh
stern -n <namespace> -l app=<app> --tail 100 | rg 'error|timeout|trace_id'
```

Evita usar Stern como almacén de trazas. No copies prompts, outputs o tokens de acceso a tickets; usa identificadores de correlación y el sistema de observabilidad aprobado.

## Combinado con

- [kubectl](kubectl.md): confirma rollout, eventos y estado de pods antes de diagnosticar desde logs.
- [K9s](k9s.md): alterna entre inspección interactiva y seguimiento reproducible en terminal.
- [DuckDB](../productivity/duckdb.md): analiza una exportación redactada de logs/trazas cuando la pregunta requiere agregados, no una incidencia puntual.

## Referencias

- [Stern en GitHub](https://github.com/stern/stern)
