#!/bin/bash
CONTAINER_STRING=$1
CONTAINER_NAME=$2
PREFIX=$3

set -Cue

if [[ -z $CONTAINER_STRING ]]; then
  echo "container string is not specified" >&2
  exit 1
fi
if [[ -z $CONTAINER_NAME ]]; then
  echo "container name is not specified" >&2
  exit 1
fi
if [[ -z $PREFIX ]]; then
  echo "prefix is not specified" >&2
  exit 1
fi

az storage blob list \
  --connection-string $CONTAINER_STRING \
  --container-name $CONTAINER_NAME \
  --prefix $PREFIX \
  | jq -r '{"items": [sort_by(.properties.lastModified) | reverse | .[] | select(.name | endswith("/index.html") | not)] }' \
  | mustache /index.html.mustache \
  > index.html

az storage blob upload \
  --connection-string $CONTAINER_STRING \
  --container-name $CONTAINER_NAME \
  --name $PREFIX/index.html \
  --file index.html
