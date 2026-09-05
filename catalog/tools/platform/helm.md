# Helm

**Qué resuelve:** empaquetado y despliegue reproducible de manifiestos Kubernetes mediante charts y values.

## Separar chart, values y secretos

El chart expresa la plantilla; los ficheros `values` expresan configuración por entorno; los secretos siguen el flujo SOPS/Vault aprobado. Mantén values pequeños y revisables, y evita que un `--set` temporal se convierta en configuración invisible.

## Uso diario

```sh
helm repo update
helm lint <chart>
helm template <release> <chart> -f values.yaml
helm list -A
helm history <release> -n <namespace>
```

No uses `--set` para secretos. Versiona los values no sensibles y usa el flujo de secretos aprobado.

## Antes de un upgrade

Ejecuta `helm lint`, renderiza el chart con los values exactos y compara contra el API server. Guarda versión de chart, values y cambio de imagen en la misma MR.

## Combinado con

Comprueba el resultado antes del upgrade con [kubectl](kubectl.md):

```sh
helm template <release> <chart> -f values.yaml | kubectl diff -f -
```

Fuente: [Helm Documentation](https://helm.sh/docs/).
