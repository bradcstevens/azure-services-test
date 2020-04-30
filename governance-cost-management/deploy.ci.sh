#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

docker run --env-file ./.env --rm -it \
  -v $(pwd):/data \
  --workdir=/data \
  --entrypoint "/bin/sh" \
  mcr.microsoft.com/azure-cli \
  -c "/bin/az login; 