#!/bin/sh

set -Cue

az storage blob list \
  --connection-string $1 \
  --container-name $2 \
  --prefix $3 \
  | jq -r '{"items": [sort_by(.properties.lastModified) | reverse | .[] | select(.name | endswith("/index.html") | not)] }' \
  | mustache /index.html.mustache \
  > index.html
az storage blob upload \
  --connection-string $1 \
  --container-name $2 \
  --name $3/index.html \
  --file index.html
