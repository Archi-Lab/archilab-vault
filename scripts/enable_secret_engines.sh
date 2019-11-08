#!/usr/bin/env bash

SECRET_SYS="sys/mounts/secret"

# Enable K/V engine
curl \
    --location \
    --fail \
    --header "X-Vault-Token: ${VAULT_TOKEN}" \
    --data "@./data/${SECRET_SYS}/secret.json" \
    "${VAULT_ADDR}/v1/${SECRET_SYS}"
