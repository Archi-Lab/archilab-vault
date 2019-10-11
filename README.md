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

## Initialize Vault

Initilialize Vault with 1 key share and a threshold of 1 (see
[Shamir's Secret Sharing](https://en.wikipedia.org/wiki/Shamir%27s_Secret_Sharing))
and store the output in the current user's home directory:

```bash
./init_vault
```

## Unseal Vault

Unseal Vault with the unseal key from the output of the initialization process:

```bash
cat ~/vault-init.txt
```

```bash
vault operator unseal
```
