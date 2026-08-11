# snelf-icloud-mcp

Containerized iCloud MCP sidecar for Snelf.

It combines:

- [icloud-mcp](https://github.com/ThomasCrouzet/icloud-mcp)
- [Supergateway](https://github.com/supercorp-ai/supergateway)

`icloud-mcp` runs as a local stdio MCP server inside the container.
Supergateway exposes it as Streamable HTTP for Snelf / Hermes.

## Architecture

```text
Snelf / Hermes
      |
      | Streamable HTTP
      | http://icloud-mcp:8000/mcp
      v
Supergateway
      |
      | stdio
      v
icloud-mcp
      |
      v
iCloud
