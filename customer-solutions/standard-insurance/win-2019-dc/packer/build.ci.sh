#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

docker run --rm -it \
  -e $ARM_CLIENT_ID \
  -e $ARM_CLIENT_SECRET \
  -e $ARM_SUBSCRIPTION_ID \
  -e $ARM_TENANT_ID \
  -e $ARM_OBJECT_ID \
  -e $SUBSCRIPTION_NAME \
  -e $RG_NAME \
  -e $LOCATION \
  -e $TAGS \
  -v $(pwd):/data \
  --workdir=/data \
  --entrypoint "/bin/sh" \
  hashicorp/packer:light \
  -c "/bin/packer build win-2019-dc.json;"