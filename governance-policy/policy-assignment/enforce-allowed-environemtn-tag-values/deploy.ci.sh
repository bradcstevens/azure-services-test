#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

docker run --env-file ./.env --rm -it \
  -v $(pwd):/data \
  --workdir=/data \
  --entrypoint "/bin/sh" \
  hashicorp/terraform:light \
  -c "/bin/terraform init; \
      /bin/terraform get; \
      /bin/terraform validate; \
      /bin/terraform plan -out=out.tfplan; \
      /bin/terraform apply out.tfplan;"