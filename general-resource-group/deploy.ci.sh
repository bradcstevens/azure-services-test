#!/bin/bash
set -euo pipefail
IFS=$'\n\t' 

# source .env

docker run --rm -i \
    -e $ARM_CLIENT_NAME \
    -e $ARM_CLIENT_SECRET \
    -e $ARM_TENANT_ID \
    -e $ARM_SUBSCRIPTION_ID \
    -e $RG_NAME \
    -e $RG_LOCATION \
    -e $TAGS \
    -v $(pwd):/data \
    --workdir=/data \
    --entrypoint "/bin/sh" \
    mcr.microsoft.com/azure-cli \
    -c "az login \
        --service-principal \
        --username $ARM_CLIENT_NAME \
        --tenant $ARM_TENANT_ID \
        --password $ARM_CLIENT_SECRET \
        > /dev/null; \

        az account set \
            --subscription '$ARM_SUBSCRIPTION_ID' \
            > /dev/null; \

        az deployment create \
            --name resource-group-create \
            --location $RG_LOCATION \
            --template-file azuredeploy.json \
            --parameters rgName=$RG_NAME rgLocation=$RG_LOCATION tags=$TAGS;"


# cleanup deployed azure resources via azure-cli

: '
docker run --rm -i \
    -e $ARM_CLIENT_NAME \
    -e $ARM_CLIENT_SECRET \
    -e $ARM_TENANT_ID \
    -e $ARM_SUBSCRIPTION_ID \
    -e $RG_NAME \
    -v $(pwd):/data \
    --workdir=/data \
    --entrypoint "/bin/sh" \
    mcr.microsoft.com/azure-cli \
    -c "az login \
        --service-principal \
        --username $ARM_CLIENT_NAME \
        --tenant $ARM_TENANT_ID \
        --password $ARM_CLIENT_SECRET \
        > /dev/null; \

        az account set \
        --subscription '$ARM_SUBSCRIPTION_ID' \
        > /dev/null; \

        az group show \
            --name $RG_NAME \
            --subscription '$ARM_SUBSCRIPTION_ID';"


docker run --rm -i \
    -e $ARM_CLIENT_NAME \
    -e $ARM_CLIENT_SECRET \
    -e $ARM_TENANT_ID \
    -e $ARM_SUBSCRIPTION_ID \
    -e $RG_NAME \
    -v $(pwd):/data \
    --workdir=/data \
    --entrypoint "/bin/sh" \
    mcr.microsoft.com/azure-cli \
    -c "az login \
        --service-principal \
        --username $ARM_CLIENT_NAME \
        --tenant $ARM_TENANT_ID \
        --password $ARM_CLIENT_SECRET \
        > /dev/null; \

        az account set \
        --subscription '$ARM_SUBSCRIPTION_ID' \
        > /dev/null; \

        az group delete \
            --name $RG_NAME \
            --yes;"
'