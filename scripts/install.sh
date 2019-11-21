#!/usr/bin/env bash

set -e

VAULT_VERSION="1.2.3"
RELEASES_URL="https://releases.hashicorp.com/vault"
ZIP_NAME="vault_${VAULT_VERSION}_linux_amd64.zip"
ZIP_URL="${RELEASES_URL}/${VAULT_VERSION}/${ZIP_NAME}"

# Install dependencies
apt update --yes
apt install --yes curl unzip jq

# Download and install Vault binary
pushd .
cd /tmp
curl --location --remote-name "${ZIP_URL}"
unzip "${ZIP_NAME}"
mv vault /usr/local/bin/
popd

# Allow mlock syscall
setcap cap_ipc_lock=+ep /usr/local/bin/vault

# Install Vault as a systemd service
cp ./config/vault.service /etc/systemd/system/

# Create a Vault user
set +e
useradd --system --home /etc/vault --shell /bin/false vault &>/dev/null
set -e

# Create Vault directories and install configuration file
mkdir --parents /etc/vault
cp ./config/config.json /etc/vault/
chown --recursive vault:vault /etc/vault
chmod 640 /etc/vault/config.json
mkdir --parents /var/lib/vault
chown --recursive vault:vault /var/lib/vault

# Install scripts
cp ./scripts/unseal.sh /etc/vault
echo "https://vault.archi-lab.io" > /etc/vault/vault-addr.txt

# Enable and start Vault service
systemctl enable --now vault
