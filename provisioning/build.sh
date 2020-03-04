#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail
IFS=$'\n\t'

workdir="$(
  cd "$(dirname "$0")"
  pwd
)"

docker build \
  --file "${workdir}/docker/Dockerfile" \
  --tag 'archilab-vault-provisioner' \
  "${workdir}/context"
