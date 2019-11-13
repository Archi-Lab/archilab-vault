# ArchiLab Vault

This repository contains scripts to setup
[Hashicorp Vault](https://www.vaultproject.io/).

## Install Vault

Download and install a precompiled Hashicorp Vault binary and run it as a
service:

```bash
sudo ./scripts/install.sh
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
./scripts/init.sh
source ~/.bashrc
```

## Provision Vault

The data directory is structured according to Vault's HTTP API. Every path
segment except for the last one becomes a folder. The last path segment becomes
a JSON file with the payload as its content. This makes it very easy to codify
the provisioning in a script:

```bash
./scripts/provision.sh
```

## Configure Jenkins AppRole

Read the role ID and create a secret ID for the Jenkins AppRole and store them
in the home directory of the current user:

```bash
./scripts/configure_jenkins_approle.sh
```

## Uninstall Vault

```bash
sudo ./scripts/uninstall_vault.sh
```
