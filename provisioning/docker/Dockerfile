FROM ubuntu:18.04

# Upgrade packages and install dependencies
RUN  set -eux; \
        apt-get update \
        && apt-get upgrade \
        && apt-get install --assume-yes \
            curl \
            jq \
        && rm -rf /var/lib/apt/lists/*

VOLUME ["/var/lib/vault", "/context"]

ENTRYPOINT [ "/context/docker-entrypoint.sh" ]
