#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

workdir="$(
  cd "$(dirname "$0")"
  pwd
)"

docker build \
  --file "${workdir}/docker/Dockerfile" \
  --tag 'archilab-vault' \
  "${workdir}/context"
