# Sample Cost Management Solution

# Description
Creates and Deploys the following:

#### Azure CLI
* Azure Automation Account Resource Group
* Azure Service Principal
* Creates an Azure Cost Management Budget on a Resource Group

#### ARM Template
* Azure Automation Account
    * Configures Service Principal as a Credential Asset
    * Configures Azure Automation Account Runbook
* Creates an Azure Automation Account Action Group

The Azure Automation script turns of all the VMs in an Azure Resource Group or Subscription if a budget is hit. The Azure Automation Account Action Group will also apply a resource lock to prevent someone from turning the resource back on as well as creating more resources.

***Note:***

***The latest 2019-10-01 Azure Resource Manager API "Microsoft.Consumption/budgets" only apply at the subscription level only! It is unclear as to when or if Microsoft will update future versions of the "Microsoft.Consumption/budgets" API to support specifying a scope for budgets at the Resource Group level. Therefore the Azure CLI is used to create a budget in Azure at the Resource Group level.***

***It is also worth noting that the The Azure CLI Command group 'consumption' is in preview. When running the command, Microsoft reveals that this Azure CLI command module "...may be changed/removed in a future release."***

# Pre-requisites
* WSL or Bash CLI
* Azure CLI
  
# Steps To Deploy

## 1. Define Environment Variables (.env)
   
#### Template location
```
export JSON=''
export JSON_PARAM=''
export TEMP_JSON_PARAM=''
```

#### Subscription Settings
```
export AZURE_SUBSCRIPTION_NAME=''
```

#### Service Principal Settings
```
export AD_SP_NAME=''
export RBAC_ROLE=''
```

#### Azure Automation Settings
```
export RG_NAME=''
export LOCATION=''
export DEPLOYMENT_NAME=''
export CREDENTIAL_NAME=''
export TAGS=''
```

#### Azure Budget Settings
```
export BUDGET_NAME=''
export BUDGET_AMOUNT=''
export BUDGET_FREQUENCY=''
export BUDGET_START_DATE=''
export BUDGET_END_DATE=''
export BUDGET_RESOURCE_GROUP_NAME=''
```

#### Action Group Settings
```
export ACTION_GROUP_NAME=''
export ACTION_GROUP_SHORT_NAME=''
```