#!/usr/bin/env bash

POLICY_ADMIN="sys/policy/admin"

# Workaround (https://github.com/hashicorp/vault/issues/582#issuecomment-390460260)
ADMIN_POLICY="$(jq -c '.' ./data/${POLICY_ADMIN}/admin.json | sed 's/"/\\\"/g')"
echo "{\"policy\":\"${ADMIN_POLICY}\"}" > /tmp/admin.json

# Create admin policy
curl \
    --location \
    --fail \
    --header "X-Vault-Token: ${VAULT_TOKEN}" \
    --upload-file /tmp/admin.json \
    "${VAULT_ADDR}/v1/${POLICY_ADMIN}"
