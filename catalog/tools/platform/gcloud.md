# Google Cloud SDK (`gcloud`)

**Qué resuelve:** autenticación y administración de recursos de Google Cloud desde terminal.

## Configuraciones y cuentas

Usa configuraciones nombradas para separar sandbox y producción. Una configuración guarda proyecto, cuenta, región y otros valores activos; evita cambiar el contexto “por memoria”.

```sh
gcloud config configurations create sandbox
gcloud config set project <SANDBOX_PROJECT_ID>
gcloud config configurations list
```

## Uso diario

```sh
gcloud init
gcloud auth list
gcloud config list
gcloud projects list
gcloud config set project <PROJECT_ID>
```

Separa configuraciones personales, sandbox y producción. No uses cuentas privilegiadas para trabajo diario ni exportes credenciales a ficheros versionados.

## Antes de una acción mutable

Verifica cuenta y proyecto con `gcloud auth list` y `gcloud config list`. Para automatización, usa identidades de servicio o federación aprobada, con permisos mínimos y rotación gestionada.

## Combinado con

Obtén credenciales de un clúster y usa [kubectl](kubectl.md):

```sh
gcloud container clusters get-credentials <cluster> --region <region> --project <PROJECT_ID>
kubectl get namespaces
```

Fuente: [gcloud CLI](https://cloud.google.com/sdk/gcloud/reference).
