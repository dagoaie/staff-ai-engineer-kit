# jq

**Qué resuelve:** transforma y consulta JSON desde la terminal.

## Uso diario

```sh
jq '.' response.json
jq -r '.items[].name' response.json
jq '{id, status}' response.json
curl -sS <url> | jq '.data'
```

Usa `-r` solo cuando necesites texto sin comillas; valida la estructura antes de automatizarla.

## Combinado con

Consulta datos JSON de GCP y filtra campos concretos:

```sh
gcloud projects list --format=json | jq -r '.[].projectId'
```

Fuente: [jq manual](https://jqlang.org/manual/).
