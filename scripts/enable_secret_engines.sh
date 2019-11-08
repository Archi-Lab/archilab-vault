#!/usr/bin/env bash

KV_SYS="sys/mounts/kv"

# Enable K/V engine
curl \
    --location \
    --fail \
    --header "X-Vault-Token: ${VAULT_TOKEN}" \
    --data "@./data/${KV_SYS}/kv.json" \
    "${VAULT_ADDR}/v1/${KV_SYS}"
