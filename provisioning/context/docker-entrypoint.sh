#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
shopt -s nullglob

vault_address='http://vault:8200'
vault_dir='/var/lib/vault'
init_file="${vault_dir}/vault-init.json"
vault_token="$(jq --raw-output '.root_token' "${init_file}")"

is_initialized_unsealed_active() {
  local health_url="${vault_address}/v1/sys/health"
  local status_code=0

  status_code="$(
    (curl --silent --head "${health_url}" 2> /dev/null || true) \
      | head --lines=1 \
      | cut --delimiter=' ' --fields=2
  )"

  [[ ${status_code} == 200 ]]
}

provision() {
  for file in "$1"/*.json; do
    local path="${file%.json}"
    echo "Provisioning ${path}"

    if [[ $2 == 'post' ]]; then
      curl \
        --silent \
        --fail \
        --header "X-Vault-Token: ${vault_token}" \
        --data "@${file}" \
        "${vault_address}/v1/${path}"
    elif [[ $2 == "put" ]]; then
      # Workaround (https://github.com/hashicorp/vault/issues/582#issuecomment-390460260)
      if [[ $1 =~ ^sys/policy.* ]]; then
        policy="{\"policy\":\"$(jq -c '.' "${file}" | sed 's/"/\\\"/g')\"}"

        curl \
          --silent \
          --fail \
          --header "X-Vault-Token: ${vault_token}" \
          --upload-file <(cat <<< "${policy}") \
          "${vault_address}/v1/${path}"
      else
        curl \
          --silent \
          --fail \
          --header "X-Vault-Token: ${vault_token}" \
          --upload-file "${file}" \
          "${vault_address}/v1/${path}"
      fi
    else
      echo 'No post or put parameter' >&2
      exit 1
    fi
  done
}

provision_approle_secret() {
  local approle_url="${vault_address}/v1/auth/approle/role/$1"

  curl \
    --silent \
    --fail \
    --header "X-Vault-Token: ${vault_token}" \
    --output "${vault_dir}/$1-role-id.json" \
    "${approle_url}/role-id"

  curl \
    --silent \
    --fail \
    --header "X-Vault-Token: ${vault_token}" \
    --data '@/dev/null' \
    --output "${vault_dir}/$1-secret-id.json" \
    "${approle_url}/secret-id"
}

provision_all() {
  pushd '/context/data' > '/dev/null'
  provision 'sys/auth' 'post'
  provision 'sys/mounts' 'post'
  provision 'sys/policy' 'put'
  provision 'auth/approle/role' 'post'
  provision 'auth/github' 'post'
  provision 'secret/data/archilab/google/user' 'post'
  provision 'secret/data/archilab/greylog/user' 'post'
  provision 'secret/data/archilab/jenkins' 'post'
  provision 'secret/data/archilab/keycloak/old' 'post'
  provision 'secret/data/archilab/keycloak/user' 'post'
  provision 'secret/data/archilab/nas/user' 'post'
  provision 'secret/data/archilab/nexus/user' 'post'
  provision 'secret/data/archilab/raumbuchung/user' 'post'
  provision 'secret/data/archilab/twitter/user' 'post'
  provision 'secret/data/archilab/vimeo/user' 'post'
  popd > '/dev/null'

  provision_approle_secret 'jenkins'
  provision_approle_secret 'keycloak'
}

main() {
  if is_initialized_unsealed_active; then
    echo 'Vault is initialized, unsealed and active. Provisioning'
    provision_all
  else
    echo 'Vault is not ready for provisioning.' >&2
    exit 1
  fi
}

main
