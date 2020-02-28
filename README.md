# ArchiLab Vault

This repository contains scripts, Docker image/compose files and provisioning
configuration to setup [Hashicorp Vault](https://www.vaultproject.io/) for
ArchiLab.

## Deploy Vault

Build the Docker image:

```bash
deployment/build.sh
```

Deploy the Docker stack:

```bash
deployment/run.sh
```

Remove the Docker stack:

```bash
deployment/stop.sh
```

## Provision Vault

The data directory is structured according to
[Vault's HTTP API](https://www.vaultproject.io/api-docs/). Every path segment
except for the last one becomes a folder. The last path segment becomes a JSON
file with the payload as its content. This makes it very easy to codify the
provisioning in a script.

Build the Docker image:

```bash
provisioning/build.sh
```

Provision according to configuration in
`provisioning/context/docker-entrypoint.sh`:

```bash
provisioning/run.sh ./scripts/provision.sh
```

## Provision secrets

To create secrets put JSON files containing the secrets inside the directory
`provisioning/context/data/secret/data` and adjust
`provisioning/context/docker-entrypoint.sh`. Those changes should never be
pushed to git since they contain sensitive data.

### Example:

#### **`provisioning/context/data/secret/data/my/secret/path.json`**

```json
{
  "data": {
    "key1": "value1",
    "key2": "value2"
  }
}
```

#### **`provisioning/context/docker-entrypoint.sh`**

```bash
provision_all() {
  pushd '/context/data' > '/dev/null'
  ...
  provision 'secret/data/my/secret' 'post'
  ...
  popd > '/dev/null'
  ...
}
```
