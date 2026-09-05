# kubectl

**Qué resuelve:** cliente de la API de Kubernetes para inspeccionar y administrar clústeres autorizados.

## Lectura antes de escritura

El orden seguro es: identificar contexto, inspeccionar el recurso, renderizar/difear el cambio y solo entonces aplicar el procedimiento aprobado. Los comandos `get`, `describe`, `events` y `logs` cubren la mayoría de diagnósticos sin mutar el clúster.

## Uso diario

```sh
kubectl config current-context
kubectl get pods -n <namespace>
kubectl describe deployment <nombre> -n <namespace>
kubectl logs deploy/<nombre> -n <namespace> --tail=100
```

Comprueba contexto y namespace antes de cualquier mutación. Prefiere `diff`, `--dry-run=client` y revisiones por MR.

## Diagnóstico de un despliegue

```sh
kubectl rollout status deploy/<nombre> -n <namespace>
kubectl get events -n <namespace> --sort-by=.lastTimestamp
kubectl logs deploy/<nombre> -n <namespace> --previous --tail=100
```

La presencia de un Pod no prueba que la ruta de negocio funcione: contrasta readiness, logs, métricas y una prueba funcional.

## Combinado con

Renderiza primero con [Helm](helm.md) antes de aplicar:

```sh
helm template <release> <chart> -n <namespace> | kubectl diff -f -
```

Fuente: [kubectl Reference](https://kubernetes.io/docs/reference/kubectl/).
