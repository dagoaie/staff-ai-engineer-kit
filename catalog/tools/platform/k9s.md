# K9s

**Qué resuelve:** interfaz terminal para explorar recursos, eventos y logs Kubernetes.

## Uso diario

```sh
k9s
k9s --context <contexto>
k9s --namespace <namespace>
```

K9s conserva las credenciales de tu contexto actual: trátalo como `kubectl` y confirma el clúster antes de realizar acciones.

## Combinado con

Selecciona un contexto seguro con [kubectx](kubectx.md) antes de abrirlo:

```sh
kubectx <contexto-sandbox>
k9s
```

Fuente: [K9s Documentation](https://k9scli.io/).
