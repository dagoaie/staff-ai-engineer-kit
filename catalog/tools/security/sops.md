# SOPS

**Qué resuelve:** cifra valores de configuración en YAML, JSON, dotenv u otros formatos, conservando la estructura revisable.

## Modelo de acceso

Los destinatarios de cifrado representan quién puede descifrar, no quién debería ver cada secreto. Divide archivos y reglas cuando distintos entornos o equipos tengan necesidades de acceso diferentes. Prueba el descifrado en CI con una identidad no humana aprobada.

## Uso diario

```sh
sops --encrypt --age <recipient> secrets.yaml > secrets.enc.yaml
sops secrets.enc.yaml
sops --decrypt secrets.enc.yaml
sops --version
```

Solo cifra secretos necesarios. Protege las claves privadas fuera de Git y define destinatarios/rotación por organización.

## Combinado con

Usa una identidad [age](age.md) local para descifrar durante desarrollo:

```sh
export SOPS_AGE_KEY_FILE="$HOME/.config/sops/age/keys.txt"
sops --decrypt secrets.enc.yaml
```

Fuente: [SOPS](https://getsops.io/).
