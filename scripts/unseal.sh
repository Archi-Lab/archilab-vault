#!/usr/bin/env bash

set -e

VAULT_DIR="/etc/vault"
VAULT_ADDR="$(< "${VAULT_DIR}/vault-addr.txt")"
SYS_UNSEAL="sys/unseal"

jq '. | {key: .keys[0]}' "${VAULT_DIR}/vault-init.json" > "/tmp/vault-unseal.json"

curl \
    --silent \
    --location \
    --fail \
    --upload-file "/tmp/vault-unseal.json" \
    "${VAULT_ADDR}/v1/${SYS_UNSEAL}"
