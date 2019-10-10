# ArchiLab Vault

This repository contains scripts to setup [Hashicorp Vault](https://www.vaultproject.io/).

## Install Vault

Download and install a precompiled Hashicorp Vault binary to /usr/local/bin:

```bash
sudo ./install_vault
```

## Create Vault User

Create a system user to run Vault:

```bash
sudo ./create_user
```

## Install Vault Service

Create a Vault service file and neccessary folders to run Vault:

```bash
sudo ./install_service
```

## Install Autocompletion

Install autocompletion for the current user to use the Vault CLI:

```bash
./install_autocompletion
```
