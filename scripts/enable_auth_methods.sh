#!/usr/bin/env bash

GITHUB_SYS="sys/auth/github"
GITHUB_CONFIG="auth/github/config"
APPROLE_SYS="sys/auth/approle"

# Enable GitHub Auth
curl \
    --location \
    --fail \
    --header "X-Vault-Token: ${VAULT_TOKEN}" \
    --data "@./data/${GITHUB_SYS}/github.json" \
    "${VAULT_ADDR}/v1/${GITHUB_SYS}"

# Configure GitHub Auth
curl \
    --location \
    --fail \
    --header "X-Vault-Token: ${VAULT_TOKEN}" \
    --data "@./data/${GITHUB_CONFIG}/config.json" \
    "${VAULT_ADDR}/v1/${GITHUB_CONFIG}"

# Enable AppRole Auth
curl \
    --location \
    --fail \
    --header "X-Vault-Token: ${VAULT_TOKEN}" \
    --data "@./data/${APPROLE_SYS}/approle.json" \
    "${VAULT_ADDR}/v1/${APPROLE_SYS}"
