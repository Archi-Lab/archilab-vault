#!/usr/bin/env bash

vault -autocomplete-install
echo "export VAULT_ADDR=https://vault.archi-lab.io" >> "${HOME}/.bashrc"
