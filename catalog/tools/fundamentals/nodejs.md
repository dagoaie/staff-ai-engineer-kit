# Node.js

**Qué resuelve:** runtime para OpenSpec, MCP Inspector, Promptfoo y el instalador de Skills.

## Uso diario

```sh
node --version
npm --version
npx <paquete> --help
npm outdated --global
```

Prefiere dependencias de proyecto para aplicaciones; reserva instalaciones globales para CLIs. Promptfoo requiere una versión de Node actual.

## Combinado con

Fija el runtime del repositorio antes de usar una CLI Node:

```sh
mise use --local node@24
npx @modelcontextprotocol/inspector --help
```

Fuente: [Node.js Documentation](https://nodejs.org/docs/latest/api/).
