#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

docker stack rm 'archilab-vault'
