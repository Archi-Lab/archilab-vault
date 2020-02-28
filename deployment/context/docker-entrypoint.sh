#!/usr/bin/env bash
set -eumo pipefail
IFS=$'\n\t'

vault_address='http://vault:8200'
init_config='/etc/vault/init.json'
init_file='/var/lib/vault/vault-init.json'

is_initialized() {
  local health_url="${vault_address}/v1/sys/health"
  local status_code=0
  local counter=15

  status_code="$(
    (curl --silent --head "${health_url}" 2> /dev/null || true) \
      | head --lines=1 \
      | cut --delimiter=' ' --fields=2
  )"

  # Check status code every 2 seconds at most 15 times
  until [[ ${counter} == 0 ]] \
    || [[ ${status_code} == 200 ]] \
    || [[ ${status_code} == 429 ]] \
    || [[ ${status_code} == 472 ]] \
    || [[ ${status_code} == 473 ]] \
    || [[ ${status_code} == 501 ]] \
    || [[ ${status_code} == 503 ]]; do
    ((counter--))
    sleep 2
    status_code="$(
      (curl --silent --head ${health_url} 2> /dev/null || true) \
        | head --lines=1 \
        | cut --delimiter=' ' --fields=2
    )"
  done

  # Return status code 0 (success) if status code is not 501 (not initialized)
  [[ ${status_code} != 501 ]]
}

initialize_vault() {
  local init_url="${vault_address}/v1/sys/init"

  curl \
    --silent \
    --fail \
    --upload-file "${init_config}" \
    --output "${init_file}" \
    "${init_url}"

  chown vault:vault "${init_file}"
}

unseal_vault() {
  local unseal_url="${vault_address}/v1/sys/unseal"
  local payload=''

  payload="$(jq '. | {key: .keys[0]}' "${init_file}")"

  curl \
    --silent \
    --fail \
    --fail \
    --upload-file <(cat <<< "${payload}") \
    "${unseal_url}"
}

main() {
  # Start Vault in background
  /usr/local/bin/vault server -config=/etc/vault/config.json &

  # Initialize Vault if it isn't already
  if ! is_initialized; then
    echo 'Vault is uninitialized. Starting initialization.'
    initialize_vault
  else
    echo 'Vault is initialized already'
  fi

  # Unseal Vault
  echo 'Unsealing Vault'
  unseal_vault

  # Bring Vault back to foreground
  fg
}

main
