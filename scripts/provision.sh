#!/usr/bin/env bash
set -e

shopt -s nullglob

provision_post() {
    set +e
    pushd "$1" > /dev/null
    for f in $(ls "$1"/*.json); do
        p="$1/${f%.json}"
        echo "Provisioning $p"
        curl \
            --silent \
            --location \
            --fail \
            --header "X-Vault-Token: ${VAULT_TOKEN}" \
            --data @"${f}" \
            "${VAULT_ADDR}/v1/${p}"
    done
    popd > /dev/null
    set -e
}

provision_put() {
    set +e
    pushd "$1" > /dev/null
    for f in $(ls "$1"/*.json); do
        p="$1/${f%.json}"
        
        if [[ $1 =~ ^sys/policy.* ]]; then
            # Workaround (https://github.com/hashicorp/vault/issues/582#issuecomment-390460260)
            policy="$(jq -c '.' ./data/${POLICY_ADMIN}/admin.json | sed 's/"/\\\"/g')"
            f="{\"policy\":\"${policy}\"}"
        fi

        echo "Provisioning $p"
        curl \
            --silent \
            --location \
            --fail \
            --header "X-Vault-Token: ${VAULT_TOKEN}" \
            --upload_file "${f}" \
            "${VAULT_ADDR}/v1/${p}"
    done
    popd > /dev/null
    set -e
}

echo "Verifying Vault is unsealed"
vault status > /dev/null

pushd data >/dev/null
provision_post sys/auth
provision_post sys/mounts
provision_put sys/policy
provision_post auth/approle/role
provision_post auth/github
popd > /dev/null
