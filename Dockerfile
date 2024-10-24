FROM alpine AS mustache-downloader

RUN apk --update add curl tar

ARG MUSTACHE_VERSION=1.3.0
RUN curl -sSL https://github.com/cbroglie/mustache/releases/download/v${MUSTACHE_VERSION}/mustache_${MUSTACHE_VERSION}_linux_amd64.tar.gz \
  | tar xzf - \
 && mv mustache /usr/local/bin/mustache

FROM mcr.microsoft.com/azure-cli

COPY --from=mustache-downloader /usr/local/bin/mustache /usr/local/bin/mustache
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY index.html.mustache /index.html.mustache

ENTRYPOINT ["/docker-entrypoint.sh"]
