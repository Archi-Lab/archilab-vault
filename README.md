# ArchiLab Vault

This repository contains scripts to setup
[Hashicorp Vault](https://www.vaultproject.io/).

## Install Vault

Download and install a precompiled Hashicorp Vault binary and run it as a
service:

```bash
sudo ./install_vault
```

## Configure Shell

Install autocompletion and set Vault address for the current user:

```bash
./configure_shell
```

## Initialize and unseal Vault

Initilialize Vault with 1 key share and a threshold of 1 (see
[Shamir's Secret Sharing](https://en.wikipedia.org/wiki/Shamir%27s_Secret_Sharing))
and store the output in the current user's home directory:

```bash
./init_unseal
```

## Create policies

Create ACL policies for Vault:

```bash
./create_policies
```
