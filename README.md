# ArchiLab Vault

This repository contains scripts to setup
[Hashicorp Vault](https://www.vaultproject.io/).

## Install Vault

Download and install a precompiled Hashicorp Vault binary and run it as a
service:

```bash
sudo ./scripts/install.sh
```

## Initialize Vault

Initilialize Vault with 1 key share and a threshold of 1 (see
[Shamir's Secret Sharing](https://en.wikipedia.org/wiki/Shamir%27s_Secret_Sharing))
and store the output in the current user's home directory:

```bash
sudo ./scripts/init.sh
```

## Install unseal service

After initialization and after every reboot Vault is in a sealed state. In order to automate the process of unsealing execute the following script:

```bash
sudo ./scripts/install-unseal-service.sh
```

## Provision Vault

The data directory is structured according to Vault's HTTP API. Every path
segment except for the last one becomes a folder. The last path segment becomes
a JSON file with the payload as its content. This makes it very easy to codify
the provisioning in a script:

```bash
sudo ./scripts/provision.sh
```

## Configure Jenkins AppRole

Read the role ID and create a secret ID for the Jenkins AppRole and store them
in the home directory of the current user:

```bash
sudo ./scripts/configure-jenkins-approle.sh
```

## Create secrets

To create secrets put JSON files containing the secrets inside the directory `data/secret/data` and adjust the script `scripts/create-secrets.sh`. Those changes should never be pushed since they contain sensitive data.

### Example:

#### **`my/secret/path.json`**

```json
{
  "data": {
    "key1": "value1",
    "key2": "value2"
  }
}
```

#### **`scripts/create-secrets.sh`**

```bash
...

pushd data >/dev/null
provision_post secret/data/my/secret
popd > /dev/null
```

Create secrets:

```bash
sudo ./scripts/create-secrets.sh
```

## Uninstall Vault

```bash
sudo ./scripts/uninstall-vault.sh
```
