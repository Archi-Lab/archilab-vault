#!/usr/bin/env bash

vault -autocomplete-install
complete -C /usr/local/bin/vault vault

echo "export VAULT_ADDR=https://vault.archi-lab.io" >> "${HOME}/.bashrc"
export VAULT_ADDR="https://vault.archi-lab.io"
