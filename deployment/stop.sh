#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail
IFS=$'\n\t'

docker stack rm 'archilab-vault'
