#!/usr/bin/env bash

set -e

VAULT_DIR="/etc/vault"
VAULT_ADDR="$(< "${VAULT_DIR}/vault-addr.txt")"
VAULT_TOKEN="$(jq --raw-output '.root_token' "${VAULT_DIR}/vault-init.json")"
APPROLE_JENKINS="auth/approle/role/jenkins"

curl \
    --location \
    --header "X-Vault-Token: ${VAULT_TOKEN}" \
    --output ${VAULT_DIR}/jenkins-role-id.json \
    "${VAULT_ADDR}/v1/${APPROLE_JENKINS}/role-id"

curl \
    --location \
    --header "X-Vault-Token: ${VAULT_TOKEN}" \
    --data @/dev/null \
    --output ${VAULT_DIR}/jenkins-secret-id.json \
    "${VAULT_ADDR}/v1/${APPROLE_JENKINS}/secret-id"
