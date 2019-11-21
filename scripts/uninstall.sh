#!/usr/bin/env bash

set -e

# Stop Vault service
systemctl stop vault

# Remove Vault systemd service
rm /etc/systemd/system/vault.service

# Remove Vault binary
rm /usr/local/bin/vault

# Remove Vault directories
rm --recursive --force /etc/vault
rm --recursive --force /var/lib/vault

# Remove Vault user
deluser --remove-all-files vault
