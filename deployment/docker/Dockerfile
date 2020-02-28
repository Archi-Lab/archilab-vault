FROM ubuntu:18.04

ARG VAULT_VERSION="1.3.2"

# Upgrade packages and install dependencies
RUN  set -eux; \
        apt-get update \
        && apt-get upgrade \
        && apt-get install --assume-yes \
            curl \
            jq \
            unzip \
        && rm -rf /var/lib/apt/lists/*

# Create Vault user and directories
RUN set -eux; \
        groupadd --system --gid 999 vault \
        && useradd --system --uid 999 --gid vault \
            --home-dir /etc/vault --shell /bin/false vault \
        && mkdir --parents /etc/vault \
        && chown --recursive vault:vault /etc/vault \
        && mkdir --parents /var/lib/vault \
        && chown --recursive vault:vault /var/lib/vault

ENV RELEASES_URL="https://releases.hashicorp.com/vault"
ENV ZIP_NAME="vault_${VAULT_VERSION}_linux_amd64.zip"
ENV ZIP_URL="${RELEASES_URL}/${VAULT_VERSION}/${ZIP_NAME}"

# Download and install Vault binary
RUN set -eux; \
        cd /tmp \
        && curl --location --remote-name "${ZIP_URL}" \
        && unzip "${ZIP_NAME}" \
        && mv vault /usr/local/bin/ \
        && rm "${ZIP_NAME}"

# Install configuration file
COPY --chown=vault:vault config/config.json /etc/vault/
COPY --chown=vault:vault config/init.json /etc/vault/
RUN chmod 640 /etc/vault/config.json /etc/vault/init.json

VOLUME ["/var/lib/vault"]

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

EXPOSE 8200
