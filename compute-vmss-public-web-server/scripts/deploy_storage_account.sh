#!/bin/bash
set -euo pipefail
IFS=$'\n\t' 

PURPLE='\033[0;35'
NC='\033[0m' # No Color

# Source Environment Variables during local development
# source .env

# Download and install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Downloadd and install jq
sudo apt-get install -y jq

# Login to Azure CLI
az login \
    --service-principal \
    --username $SPN_NAME \
    --tenant $ARM_TENANT_ID \
    --password $ARM_CLIENT_SECRET \
    > /dev/null

# Set Subscription Context
az account set \
    --subscription $SUBSCRIPTION_NAME \
    > /dev/null

# Create Resource Group
az group create \
    --name $AZURE_STORAGE_ACCOUNT_RESOURCE_GROUP_NAME \
    --location $LOCATION \
    --tags $TAGS

# Create Storage Account
az storage account create \
    --name $AZURE_STORAGE_ACCOUNT \
    --resource-group $AZURE_STORAGE_ACCOUNT_RESOURCE_GROUP_NAME \
    --location $LOCATION \
    --sku $AZURE_STORAGE_ACCOUNT_SKU \
    --kind $AZURE_STORAGE_ACCOUNT_KIND \
    --tags $TAGS

# Store Storage Account Key Output in AZURE_STORAGE_ACCOUNT_KEYS Variable
AZURE_STORAGE_ACCOUNT_KEYS=$(     
az storage account keys list \
    --resource-group $AZURE_STORAGE_ACCOUNT_RESOURCE_GROUP_NAME \
    --account-name $AZURE_STORAGE_ACCOUNT
)
# Extract First Storage Account Key Value from AZURE_STORAGE_ACCOUNT_KEYS Variable into AZURE_STORAGE_KEY Variable
AZURE_STORAGE_KEY=$(jq -r '.[0] | .value' <<<"$AZURE_STORAGE_ACCOUNT_KEYS") 

# Sets the Azure Storage Account to expire 30 Minutes from the current date
AZURE_STORAGE_TOKEN_EXPIRE_TIME=$(date -u -d '30 minutes' +%Y-%m-%dT%H:%MZ)

# Captures Azure Storage Acocunt Connection String
AZURE_STORAGE_CONNECTION=$(
    az storage account show-connection-string \
    --name $AZURE_STORAGE_ACCOUNT \
    --resource-group $AZURE_STORAGE_ACCOUNT_RESOURCE_GROUP_NAME \
    --query connectionString
)

# Add Storage Acocunt Key Value to an Environment Variables '.key' file
echo "AZURE_STORAGE_KEY='"$AZURE_STORAGE_KEY"'" > .key
echo "AZURE_STORAGE_CONNECTION='"$AZURE_STORAGE_CONNECTION"'" >> .key

# Source Environment Variables with AZURE_STORAGE_KEY & AZURE_STORAGE_CONNECTION Variables
source .key

# change value of parameters json to include the storage account name
mv $JSON_PARAM $TEMP_JSON_PARAM
jq --tab '.parameters.storageAccountName.value="'"$AZURE_STORAGE_ACCOUNT"'"' $TEMP_JSON_PARAM > $JSON_PARAM
rm $TEMP_JSON_PARAM

# change value of parameters json to include the storage account key
mv $JSON_PARAM $TEMP_JSON_PARAM
jq --tab '.parameters.storageAccountKey.value="'"$AZURE_STORAGE_KEY"'"' $TEMP_JSON_PARAM > $JSON_PARAM
rm $TEMP_JSON_PARAM

# Create Storage Account 'scripts' Artificat Container 
az storage container create \
    --name "scripts" \
    --account-key $AZURE_STORAGE_KEY \
    --account-name $AZURE_STORAGE_ACCOUNT \
    --public-access blob \
    --auth-mode key

# Upload 'install_apache_vmss.sh' to 'scripts' Artificat Container 
az storage blob upload \
    --container-name "scripts" \
    --account-key $AZURE_STORAGE_KEY \
    --account-name $AZURE_STORAGE_ACCOUNT \
    --name "install_apache_vmss.sh" \
    --file "./scripts/install_apache_vmss.sh"

# Create Storage Account 'nested-templates' Artificat Container 
az storage container create \
    --name "nested-templates" \
    --account-key $AZURE_STORAGE_KEY \
    --account-name $AZURE_STORAGE_ACCOUNT \
    --public-access off \
    --auth-mode key

# Upload 'deploy-vnet.json' to 'nested-templates' Artificat Container 
az storage blob upload \
    --container-name "nested-templates" \
    --account-key $AZURE_STORAGE_KEY \
    --account-name $AZURE_STORAGE_ACCOUNT \
    --name "deploy-vnet.json" \
    --file "./nested-templates/deploy-vnet.json"

# Upload 'deploy-vmss.json' to 'nested-templates' Artificat Container 
az storage blob upload \
    --container-name "nested-templates" \
    --account-key $AZURE_STORAGE_KEY \
    --account-name $AZURE_STORAGE_ACCOUNT \
    --name "deploy-vmss.json" \
    --file "./nested-templates/deploy-vmss.json"

# Capture nested-templates Storage Account Container SAS Token value
NESTED_TEMPLATES_AZURE_STORAGE_TOKEN=$(az storage container generate-sas \
    --name nested-templates \
    --expiry $AZURE_STORAGE_TOKEN_EXPIRE_TIME \
    --permissions r \
    --output tsv \
    --connection-string $AZURE_STORAGE_CONNECTION
)

# Capture deploy-vmss.json nested-templates conatiner from storage account URL
VMSS_STORAGE_ACCOUNT_BLOB_URL_OUTPUT=$(az storage blob url \
    --container-name nested-templates \
    --name deploy-vmss.json \
    --output tsv \
    --connection-string $AZURE_STORAGE_CONNECTION
)

VNET_STORAGE_ACCOUNT_BLOB_URL_OUTPUT=$(az storage blob url \
    --container-name nested-templates \
    --name deploy-vnet.json \
    --output tsv \
    --connection-string $AZURE_STORAGE_CONNECTION
)

echo "NESTED_TEMPLATES_AZURE_STORAGE_TOKEN='"$NESTED_TEMPLATES_AZURE_STORAGE_TOKEN"'" >> .key

echo "VMSS_STORAGE_ACCOUNT_BLOB_URL='"$VMSS_STORAGE_ACCOUNT_BLOB_URL_OUTPUT"'" >> .key

echo "VNET_STORAGE_ACCOUNT_BLOB_URL='"$VNET_STORAGE_ACCOUNT_BLOB_URL_OUTPUT"'" >> .key

source .key

# change value of parameters json to include the storage account SAS
mv $JSON_PARAM $TEMP_JSON_PARAM
jq --tab '.parameters.storageAccountNestedTemplatesToken.value="'"$NESTED_TEMPLATES_AZURE_STORAGE_TOKEN"'"' $TEMP_JSON_PARAM > $JSON_PARAM
rm $TEMP_JSON_PARAM

# change value of parameters json to include the storage account SAS
mv $JSON_PARAM $TEMP_JSON_PARAM
jq --tab '.parameters.VmssStorageAccountBlobUrl.value="'"$VMSS_STORAGE_ACCOUNT_BLOB_URL"'"' $TEMP_JSON_PARAM > $JSON_PARAM
rm $TEMP_JSON_PARAM

# change value of parameters json to include the storage account SAS
mv $JSON_PARAM $TEMP_JSON_PARAM
jq --tab '.parameters.VnetStorageAccountBlobUrl.value="'"$VNET_STORAGE_ACCOUNT_BLOB_URL"'"' $TEMP_JSON_PARAM > $JSON_PARAM
rm $TEMP_JSON_PARAM