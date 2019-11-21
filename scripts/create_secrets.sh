#!/usr/bin/env bash

set -e

shopt -s nullglob

VAULT_DIR="/etc/vault"
VAULT_ADDR="$(< "${VAULT_DIR}/vault-addr.txt")"
VAULT_TOKEN="$(jq --raw-output '.root_token' "${VAULT_DIR}/vault-init.json")"

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
            POLICY="$(jq -c '.' ${f} | sed 's/"/\\\"/g')"
            echo "{\"policy\":\"${POLICY}\"}" > /tmp/policy.json
            f="/tmp/policy.json"
        fi

        curl \
            --silent \
            --location \
            --fail \
            --header "X-Vault-Token: ${VAULT_TOKEN}" \
            --upload-file "${f}" \
            "${VAULT_ADDR}/v1/${p}"
    done
    popd > /dev/null
    set -e
}

echo "Verifying Vault is unsealed"
vault status > /dev/null

pushd data >/dev/null
# provision_post secret/data/
popd > /dev/null
