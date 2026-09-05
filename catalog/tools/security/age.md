# age

**Qué resuelve:** cifrado de ficheros simple y moderno; SOPS puede usarlo como backend de claves.

## Uso diario

```sh
age-keygen -o key.txt
age -r <recipient> -o datos.age datos.txt
age -d -i key.txt -o datos.txt datos.age
age --version
```

La clave privada de `key.txt` no se versiona ni se comparte por chat. Guarda copias según la política de recuperación aprobada.

## Combinado con

Configura [SOPS](sops.md) con destinatarios age para secretos de repositorio:

```yaml
creation_rules:
  - age: <recipient>
```

Fuente: [age](https://age-encryption.org/).
