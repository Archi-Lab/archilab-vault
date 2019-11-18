#!/usr/bin/env bash

set -e

SYS_UNSEAL="sys/unseal"

jq '. | {key: .keys[0]}' "${HOME}/vault-init.json" > "${HOME}/vault-unseal.json"

curl \
    --location \
    --upload-file "${HOME}/vault-unseal.json" \
    "${VAULT_ADDR}/v1/${SYS_UNSEAL}"
