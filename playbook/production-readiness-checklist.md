# Checklist: preparación para producción AI

Marca cada punto con evidencia enlazada; “se probó manualmente” no sustituye un artefacto reproducible.

- [ ] Mapa de sistema con owners, datos y fallos conocidos.
- [ ] Scorecard verde contra baseline y casos de regresión/adversariales.
- [ ] Política de routing, fallback y kill switch revisados.
- [ ] Presupuesto de coste/latencia y alarmas definidos.
- [ ] Telemetría redactada: modelo, latencia, tokens, coste y resultado correlacionables.
- [ ] Herramientas MCP con mínimo privilegio, límites y pruebas de fallo.
- [ ] Secretos fuera de Git; escaneo de secretos y dependencias ejecutado.
- [ ] Runbook de incidente: owner, diagnóstico, rollback y comunicación.
- [ ] Plan de rollout: cohorte, criterio de ampliación y criterio de parada.

Los puntos no aplicables deben tener una razón explícita y una fecha de revisión.
