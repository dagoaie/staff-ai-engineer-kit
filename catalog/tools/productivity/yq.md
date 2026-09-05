# yq

**Qué resuelve:** consulta y modifica YAML sin convertirlo manualmente a JSON.

## Uso diario

```sh
yq '.services' compose.yaml
yq '.image.tag = "<tag>"' values.yaml
yq -o=json '.' values.yaml
yq eval-all 'select(fileIndex == 0) * select(fileIndex == 1)' base.yaml prod.yaml
```

Revisa el diff antes de sobrescribir un manifiesto; `-i` modifica el fichero en sitio.

## Combinado con

Inspecciona valores renderizados por [Helm](../platform/helm.md):

```sh
helm get values <release> -n <namespace> -o yaml | yq '.image'
```

Fuente: [yq Documentation](https://mikefarah.gitbook.io/yq/).
