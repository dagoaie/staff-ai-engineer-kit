# Receta: desplegar y operar en GCP/Kubernetes

Objetivo: validar infraestructura, revisar el renderizado y operar el clúster con contexto explícito.

## Separación de responsabilidades

OpenTofu gestiona infraestructura declarada; Helm empaqueta carga de Kubernetes; `kubectl` y K9s se usan principalmente para observar y diagnosticar. Mantén la configuración de cada entorno revisable y evita arreglos manuales que diverjan de IaC o del chart.

## Pasos

Valida IaC antes de solicitar o aplicar un cambio:

```sh
tofu fmt -check
tflint --init
tflint
tofu plan -out=tfplan
tofu show tfplan
```

Configura el proyecto y obtiene credenciales del clúster autorizado:

```sh
gcloud config set project <PROJECT_ID>
gcloud container clusters get-credentials <cluster> --region <region>
kubectx
kubens <namespace>
```

Renderiza, compara y observa el despliegue:

```sh
helm template <release> <chart> -n <namespace> | kubectl diff -f -
kubectl get pods -n <namespace>
k9s --namespace <namespace>
```

## Tras el despliegue

Comprueba rollout, eventos, logs, métricas y una prueba funcional. Registra versión de imagen, release, contexto y resultado en la MR o cambio operativo para poder volver atrás con evidencia.

## Guardrails

- Un `plan` no es una aprobación: revisa cambios, identidad y entorno en la MR con `glab`.
- No ejecutes `apply`, `upgrade` o acciones de K9s contra producción sin el procedimiento de cambio aprobado.
- Confirma contexto y namespace antes de cada comando Kubernetes mutable.

Herramientas: [OpenTofu](../tools/platform/opentofu.md), [TFLint](../tools/platform/tflint.md), [gcloud](../tools/platform/gcloud.md), [kubectx](../tools/platform/kubectx.md), [Helm](../tools/platform/helm.md), [kubectl](../tools/platform/kubectl.md), [K9s](../tools/platform/k9s.md), [glab](../tools/collaboration/glab.md).
