#!/usr/bin/env bash

set -e

SYS_INIT="sys/init"

# Initialize Vault
curl \
    --location \
    --upload-file ./data/${SYS_INIT}.json \
    --output "${HOME}/vault-init.json" \
    "${VAULT_ADDR}/v1/${SYS_INIT}"

echo "export VAULT_TOKEN=$(jq --raw-output '.root_token' "${HOME}/vault-init.json")" \
    >> "${HOME}/.bashrc"
