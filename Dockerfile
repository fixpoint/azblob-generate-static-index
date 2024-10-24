FROM alpine AS mustache-downloader

RUN apk --update add curl tar

ARG TARGETARCH
ARG MUSTACHE_VERSION=1.4.0
RUN curl -sSL https://github.com/cbroglie/mustache/releases/download/v${MUSTACHE_VERSION}/mustache_${MUSTACHE_VERSION}_linux_${TARGETARCH}.tar.gz \
  | tar xzf - \
 && mv mustache /usr/local/bin/mustache

FROM mcr.microsoft.com/azure-cli

COPY --from=mustache-downloader /usr/local/bin/mustache /usr/local/bin/mustache
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY index.html.mustache /index.html.mustache

ENTRYPOINT ["/docker-entrypoint.sh"]
