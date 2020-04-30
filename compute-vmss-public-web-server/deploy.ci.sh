#!/bin/bash
set -euo pipefail
IFS=$'\n\t' 

/bin/bash ./scripts/deploy_storage_account.sh

# source .env

docker run --rm -i \
    -e $SPN_NAME \
    -e $ARM_CLIENT_SECRET \
    -e $ARM_TENANT_ID \
    -e $SUBSCRIPTION_NAME \
    -e $RG_NAME \
    -e $LOCATION \
    -e $TAGS \
    -v $(pwd):/data \
    --workdir=/data \
    --entrypoint "/bin/sh" \
    mcr.microsoft.com/azure-cli \
    -c "az login \
        --service-principal \
        --username $SPN_NAME \
        --tenant $ARM_TENANT_ID \
        --password $ARM_CLIENT_SECRET \
        > /dev/null; \

        az account set \
        --subscription '$SUBSCRIPTION_NAME' \
        > /dev/null; \

        az group create \
            --name $RG_NAME \
            --location '$LOCATION' \
            --tags '$TAGS'; \

        az group deployment create \
            --name msp-vmss-public-web-server \
            --resource-group '$RG_NAME' \
            --template-file azuredeploy.json \
            --parameters @azuredeploy.parameters.json;"
   
# cleanup deployed azure resources via azure-cli

: '
docker run --env-file ./.env --rm -it \
    -v $(pwd):/data \
    --workdir=/data \
    --entrypoint "/bin/sh" \
    mcr.microsoft.com/azure-cli \
    -c "az login \
        --service-principal \
        --username $SPN_NAME \
        --tenant $ARM_TENANT_ID \
        --password $ARM_CLIENT_SECRET \
        > /dev/null; \

        az account set \
        --subscription '$SUBSCRIPTION_NAME' \
        > /dev/null; \

        az group delete \
            --name $RG_NAME \
            --yes;"
'