# kubectx y kubens

**Qué resuelve:** cambio rápido y visible de contexto Kubernetes (`kubectx`) y namespace (`kubens`).

## Uso diario

```sh
kubectx
kubectx <contexto>
kubens
kubens <namespace>
kubectl config current-context
```

El cambio de contexto afecta a todas las herramientas que usen tu kubeconfig; verifica siempre el destino.

## Combinado con

Limita una sesión de [K9s](k9s.md) al entorno elegido:

```sh
kubectx <contexto>
kubens <namespace>
k9s
```

Fuente: [kubectx](https://github.com/ahmetb/kubectx).
