#!/usr/bin/env bash

set -e

# Stop Vault service
systemctl stop vault
systemctl stop vault-unseal

# Remove Vault systemd service
rm /etc/systemd/system/vault.service
rm /etc/systemd/system/vault-unseal.service

# Remove Vault binary
rm /usr/local/bin/vault
rm /usr/local/bin/vault-unseal

# Remove Vault directories
rm --recursive --force /etc/vault
rm --recursive --force /var/lib/vault

# Remove Vault user
deluser --remove-all-files vault
