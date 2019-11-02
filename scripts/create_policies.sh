#!/usr/bin/env bash

# Workaround (https://github.com/hashicorp/vault/issues/582#issuecomment-390460260)
ADMIN_POLICY=$(cat ./data/sys/policy/admin.json | jq -c . | sed 's/"/\\\"/g')
echo "{\"policy\":\"${ADMIN_POLICY}\"}" > /tmp/admin.json

# Create admin policy
curl \
    --silent \
    --location \
    --fail \
    --header "X-Vault-Token: ${VAULT_TOKEN}" \
    --upload-file /tmp/admin.json \
    "${VAULT_ADDR}/v1/sys/policy/admin"
