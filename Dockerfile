FROM node:22-alpine

ARG ICLOUD_MCP_VERSION=v0.4.0
ARG ICLOUD_MCP_SHA256=a49fa4da8486ad19daa8267c2aec216ac917c170561e7d3519273d922477f269
ARG SUPERGATEWAY_VERSION=3.2.0

RUN apk add --no-cache ca-certificates wget tar \
    && npm install -g "supergateway@${SUPERGATEWAY_VERSION}"

RUN set -eux; \
    ARCHIVE="icloud-mcp-${ICLOUD_MCP_VERSION}-linux-amd64.tar.gz"; \
    URL="https://github.com/ThomasCrouzet/icloud-mcp/releases/download/${ICLOUD_MCP_VERSION}/${ARCHIVE}"; \
    wget -O "/tmp/${ARCHIVE}" "${URL}"; \
    echo "${ICLOUD_MCP_SHA256}  /tmp/${ARCHIVE}" | sha256sum -c -; \
    mkdir -p /tmp/icloud; \
    tar -xzf "/tmp/${ARCHIVE}" -C /tmp/icloud; \
    BINARY="$(find /tmp/icloud -type f -name icloud-mcp | head -n1)"; \
    test -n "${BINARY}"; \
    install -m 0755 "${BINARY}" /usr/local/bin/icloud-mcp; \
    rm -rf /tmp/*

RUN addgroup -g 10000 icloud \
    && adduser -D -u 10000 -G icloud icloud

COPY --chmod=0755 docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

USER icloud

EXPOSE 8000

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD [
  "supergateway",
  "--stdio",
  "/usr/local/bin/icloud-mcp",
  "--outputTransport",
  "streamableHttp",
  "--port",
  "8000",
  "--streamableHttpPath",
  "/mcp",
  "--healthEndpoint",
  "/healthz"
]
