#!/usr/bin/env bash

set -e

VAULT_DIR="/etc/vault"
VAULT_ADDR="$(< "${VAULT_DIR}/vault-addr.txt")"
SYS_UNSEAL="sys/unseal"

jq '. | {key: .keys[0]}' "${VAULT_DIR}/vault-init.json" > "${VAULT_DIR}/vault-unseal.json"

curl \
    --location \
    --upload-file "${VAULT_DIR}/vault-unseal.json" \
    "${VAULT_ADDR}/v1/${SYS_UNSEAL}"
