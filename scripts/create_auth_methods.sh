#!/usr/bin/env bash

# Enable GitHub Auth
curl \
    --silent \
    --location \
    --fail \
    --header "X-Vault-Token: ${VAULT_TOKEN}" \
    --data @./data/sys/auth/github.json \
    "${VAULT_ADDR}/v1/sys/auth/github"

# Configure GitHub Auth
curl \
    --silent \
    --location \
    --fail \
    --header "X-Vault-Token: ${VAULT_TOKEN}" \
    --data @./data/auth/github/config/config.json \
    "${VAULT_ADDR}/v1/auth/github/config"

# Enable AppRole Auth
curl \
    --silent \
    --location \
    --fail \
    --header "X-Vault-Token: ${VAULT_TOKEN}" \
    --data @./data/sys/auth/approle.json \
    "${VAULT_ADDR}/v1/sys/auth/approle"
