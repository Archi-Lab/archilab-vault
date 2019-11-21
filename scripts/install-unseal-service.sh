#!/usr/bin/env bash

set -e

# Install unseal script
cp ./scripts/unseal.sh /usr/local/bin/vault-unseal

# Install unseal Vault as a systemd service
cp ./config/vault-unseal.service /etc/systemd/system/

# Enable and start unseal Vault service
systemctl enable --now vault-unseal
