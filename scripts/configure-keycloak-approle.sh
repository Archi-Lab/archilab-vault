#!/usr/bin/env bash

set -e

VAULT_DIR="/etc/vault"
VAULT_ADDR="$(<"${VAULT_DIR}/vault-addr.txt")"
VAULT_TOKEN="$(jq --raw-output '.root_token' "${VAULT_DIR}/vault-init.json")"
APPROLE_KEYCLOAK="auth/approle/role/keycloak"

curl \
    --location \
    --header "X-Vault-Token: ${VAULT_TOKEN}" \
    --output ${VAULT_DIR}/keycloak-role-id.json \
    "${VAULT_ADDR}/v1/${APPROLE_KEYCLOAK}/role-id"

curl \
    --location \
    --header "X-Vault-Token: ${VAULT_TOKEN}" \
    --data @/dev/null \
    --output ${VAULT_DIR}/keycloak-secret-id.json \
    "${VAULT_ADDR}/v1/${APPROLE_KEYCLOAK}/secret-id"
