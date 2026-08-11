# snelf-icloud-mcp

Containerized iCloud MCP sidecar for Snelf.

It combines:

- [icloud-mcp](https://github.com/ThomasCrouzet/icloud-mcp)
- [supergateway](https://github.com/supercorp-ai/supergateway)

`icloud-mcp` runs as a stdio MCP server and Supergateway exposes it
as Streamable HTTP for Snelf/Hermes.

## Image

```text
ghcr.io/makucode/snelf-icloud-mcp
