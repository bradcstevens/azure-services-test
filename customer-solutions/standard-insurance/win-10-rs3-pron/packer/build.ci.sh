#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

docker run --rm -it \
  -e ARM_CLIENT_ID \
  -e ARM_CLIENT_SECRET \
  -e ARM_SUBSCRIPTION_ID \
  -e ARM_TENANT_ID \
  -e ARM_OBJECT_ID \
  -v $(pwd):/data \
  --workdir=/data \
  --entrypoint "/bin/sh" \
  hashicorp/packer:light \
  -c "/bin/packer build win-10-rs3-pron.json;"