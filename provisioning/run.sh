#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

workdir="$(
  cd "$(dirname "$0")"
  pwd
)"

docker run \
  --rm \
  --name 'archilab-vault-provisioner' \
  --volume 'archilab-vault_vault-data:/var/lib/vault' \
  --volume "${workdir}/context:/context" \
  --network 'archilab-vault_vault' \
  'archilab-vault-provisioner'
