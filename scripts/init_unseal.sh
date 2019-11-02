#!/usr/bin/env bash

# Initialize Vault
curl \
    --silent \
    --location \
    --upload-file ./data/sys/init/init.json \
    --output "${HOME}/vault-init.json" \
    "${VAULT_ADDR}/v1/sys/init"

jq '. | {key: .keys[0]}' "${HOME}/vault-init.json" > "${HOME}/vault-unseal.json"
jq --raw-output '.root_token' "${HOME}/vault-init.json" > "${HOME}/vault-root-token"

curl \
    --silent \
    --location \
    --upload-file "${HOME}/vault-unseal.json" \
    "${VAULT_ADDR}/v1/sys/unseal"

rm "${HOME}/vault-init.json" "${HOME}/vault-unseal.json"

echo "export VAULT_TOKEN=$(< ${HOME}/vault-root-token)" >> "${HOME}/.bashrc"
export VAULT_TOKEN="$(< ${HOME}/vault-root-token)"
