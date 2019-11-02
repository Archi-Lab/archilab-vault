# ArchiLab Vault

This repository contains scripts to setup
[Hashicorp Vault](https://www.vaultproject.io/).

## Install Vault

Download and install a precompiled Hashicorp Vault binary and run it as a
service:

```bash
sudo ./scripts/install_vault.sh
```

## Configure Shell

Install autocompletion and set Vault address for the current user:

```bash
./scripts/configure_shell.sh
source ~/.bashrc
```

## Initialize and unseal Vault

Initilialize Vault with 1 key share and a threshold of 1 (see
[Shamir's Secret Sharing](https://en.wikipedia.org/wiki/Shamir%27s_Secret_Sharing))
and store the output in the current user's home directory:

```bash
./scripts/init_unseal.sh
source ~/.bashrc
```

## Create policies

Create admin ACL policy for Vault:

```bash
./scripts/create_policies.sh
```

## Create authentication methods

Create GitHub authentication method and grant admin policy to all ArchiLab members:

```bash
./scripts/create_auth_methods.sh
```

## Uninstall Vault

```bash
sudo ./scripts/uninstall_vault.sh
```
