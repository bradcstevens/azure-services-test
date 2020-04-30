#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# -e: immediately exit if any command has a non-zero exit status
# -o: prevents errors in a pipeline from being masked
# IFS new value is less likely to cause confusing bugs when looping arrays or arguments (e.g. $@)

# Pre-requisites
# This script requries the package "jq" to parse json values. On ubuntu, run: sudo apt-get install -y jq

#login to azure using your credentials
az account show 1> /dev/null

if [ $? != 0 ];
then
	az login
fi

#################################################
# Azure Deploy Script
#################################################

# Exit immediately if the pipeline returns a non-zero status (fails)
# Note: Using 'set -e' causes this option to be turned off. Change this command to 'set -e' to turn on.

source .env

mv $JSON_PARAM $TEMP_JSON_PARAM
jq --tab '.parameters.credentialName.value="'"$CREDENTIAL_NAME"'"' $TEMP_JSON_PARAM > $JSON_PARAM
rm $TEMP_JSON_PARAM

mv $JSON_PARAM $TEMP_JSON_PARAM
jq --tab '.parameters.location.value="'"$LOCATION"'"' $TEMP_JSON_PARAM > $JSON_PARAM
rm $TEMP_JSON_PARAM

mv $JSON_PARAM $TEMP_JSON_PARAM
jq --tab '.parameters.actionGroupName.value="'"$ACTION_GROUP_NAME"'"' $TEMP_JSON_PARAM > $JSON_PARAM
rm $TEMP_JSON_PARAM

mv $JSON_PARAM $TEMP_JSON_PARAM
jq --tab '.parameters.actionGroupShortName.value="'"$ACTION_GROUP_SHORT_NAME"'"' $TEMP_JSON_PARAM > $JSON_PARAM
rm $TEMP_JSON_PARAM

set +e

az account set \
    --subscription "$AZURE_SUBSCRIPTION_NAME"

SUBSCRIPTION_INFO="az account show \
    --subscription '$AZURE_SUBSCRIPTION_NAME'"

SUBSCRIPTION_EVAL=$(eval $SUBSCRIPTION_INFO)

SUBSCRIPTION_ID=$(jq -r '.id' <<<"$SUBSCRIPTION_EVAL")

###############################################
# Start Creation
###############################################

echo "Script will create new Service Principal Object: '$AD_SP_NAME'"
echo "Creating Service Principal..."
(
    # Create Service Principal for RBAC
    SPN_CREDENTIALS=$((
        (
            az ad sp create-for-rbac \
                --name "http://${AD_SP_NAME}" \
                --role $RBAC_ROLE \
                --scopes="/subscriptions/${SUBSCRIPTION_ID}"
        ) 1>&1
        ) 2>/dev/null
    )

    SPN_ATTRIBUTES=$(az ad sp show --id "http://${AD_SP_NAME}")

    ARM_CLIENT_ID=$(jq -r '.appId' <<<"$SPN_CREDENTIALS")
    ARM_CLIENT_SECRET=$(jq -r '.password' <<<"$SPN_CREDENTIALS")
    ARM_TENANT_ID=$(jq -r '.tenant' <<<"$SPN_CREDENTIALS")
    ARM_SUBSCRIPTION_ID=$SUBSCRIPTION_ID
    ARM_OBJECT_ID=$(jq -r '.objectId' <<<"$SPN_ATTRIBUTES")


    echo "#!/bin/sh
    echo 'Setting environment variables for script to set Service Principal parameters'
    export ARM_CLIENT_ID=$ARM_CLIENT_ID
    export ARM_CLIENT_SECRET=$ARM_CLIENT_SECRET
    export ARM_TENANT_ID=$ARM_TENANT_ID
    export ARM_SUBSCRIPTION_ID=$ARM_SUBSCRIPTION_ID
    export ARM_OBJECT_ID=$ARM_OBJECT_ID" > .spn_credentials
    
)

if [ $?  == 0 ];
 then
	echo "...Service Principal has been successfully created!"
fi

source .spn_credentials

mv $JSON_PARAM $TEMP_JSON_PARAM
jq --tab '.parameters.servicePrincipalAppID.value="'"$ARM_CLIENT_ID"'"' $TEMP_JSON_PARAM > $JSON_PARAM
rm $TEMP_JSON_PARAM

mv $JSON_PARAM $TEMP_JSON_PARAM
jq --tab '.parameters.servicePrincipalPassword.value="'"$ARM_CLIENT_SECRET"'"' $TEMP_JSON_PARAM > $JSON_PARAM
rm $TEMP_JSON_PARAM

rm -rf .spn_credentials

az group create \
	--location $LOCATION \
	--name $RG_NAME \
	--tags $TAGS
    
az consumption budget create \
    --budget-name $BUDGET_NAME \
    --amount $BUDGET_AMOUNT \
    --category $BUDGET_CATEGORY \
    --time-grain $BUDGET_FREQUENCY \
    --start-date $BUDGET_START_DATE \
    --end-date $BUDGET_END_DATE \
    --resource-group $BUDGET_RESOURCE_GROUP_NAME \
    --subscription $AZURE_SUBSCRIPTION_NAME

az group deployment create \
	--template-file $JSON \
	--parameters $JSON_PARAM \
	--name $DEPLOYMENT_NAME \
	--resource-group $RG_NAME \
	--subscription $AZURE_SUBSCRIPTION_NAME