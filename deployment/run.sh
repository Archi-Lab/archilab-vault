#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail
IFS=$'\n\t'

workdir="$(
  cd "$(dirname "$0")"
  pwd
)"

docker stack deploy \
  --compose-file "${workdir}/docker/docker-compose.yml" \
  'archilab-vault'
