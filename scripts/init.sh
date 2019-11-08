#!/usr/bin/env bash

SYS_INIT="sys/init"
SYS_UNSEAL="sys/unseal"

# Initialize Vault
curl \
    --location \
    --upload-file ./data/${SYS_INIT}/init.json \
    --output "${HOME}/vault-init.json" \
    "${VAULT_ADDR}/v1/${SYS_INIT}"

jq '. | {key: .keys[0]}' "${HOME}/vault-init.json" > "${HOME}/vault-unseal.json"

curl \
    --location \
    --upload-file "${HOME}/vault-unseal.json" \
    "${VAULT_ADDR}/v1/${SYS_UNSEAL}"

rm "${HOME}/vault-unseal.json"

echo "export VAULT_TOKEN=$(jq --raw-output '.root_token' "${HOME}/vault-init.json")" \
    >> "${HOME}/.bashrc"
