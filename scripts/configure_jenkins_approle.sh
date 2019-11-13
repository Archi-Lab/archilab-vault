#!/usr/bin/env bash

set -e

curl \
    --location \
    --header "X-Vault-Token: ${VAULT_TOKEN}" \
    --output ${HOME}/jenkins-role-id.json \
    ${VAULT_ADDR}/v1/auth/approle/role/jenkins/role-id

curl \
    --location \
    --header "X-Vault-Token: ${VAULT_TOKEN}" \
    --data @/dev/null \
    --output ${HOME}/jenkins-secret-id.json \
    ${VAULT_ADDR}/v1/auth/approle/role/jenkins/secret-id
