#!/usr/bin/env bash

set -e

VAULT_DIR="/etc/vault"
VAULT_ADDR="$(< "${VAULT_DIR}/vault_addr.txt")"
SYS_INIT="sys/init"

# Initialize Vault
curl \
    --location \
    --upload-file ./data/${SYS_INIT}.json \
    --output "${VAULT_DIR}/vault-init.json" \
    "${VAULT_ADDR}/v1/${SYS_INIT}"
