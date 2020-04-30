# Azure Functions

This template deploys an Azure Function App using the PowerShell Runtime.

## Overview 

Azure Functions allows you to run small pieces of code (called "functions") without worrying about application infrastructure. With Azure Functions, the cloud infrastructure provides all the up-to-date servers you need to keep your application running at scale.

A function is "triggered" by a specific type of event. Supported triggers include responding to changes in data, responding to messages, running on a schedule, or as the result of an HTTP request.

## Deployed Resources
The following resources are deployed as part of the solution:

+ **Storage Account**: Storage Account for the Azure Function App
+ **Application Insights**: Application Insights to store logging data for the Azure Function App
+ **App Service Plan**: App Service Plan using the Consumption Model for our Function App to operate against
+ **Function App**: Function App to store Functions that execute serverless code

## Prerequisites
Users will need the "Azure" PowerShell module installed to run the deployment commands. Users can install/import that module with the following commands:

    Install-Module -Name Az -AllowClobber -Force | Import-Module -Name Az

Users will also need the Azure CLI installed.  See the following link to install the Azure CLI on your Operating System:

    https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest

## Deployment steps
1. Open "AzureFunctionsDeploy.ps1" and modify the name of the Resource Group and/or Location you would like the Function App deployed to.<br>
2. Open "azuredeploy.parameters.json" and provide a value for the Function App Name within the AppName parameter.
3. Run the "AzureFunctionsDeploy.ps1" script from an administrative PowerShell session.
    
## Example
### Hypothetical Use Case
Customer has a requirement about being able to call a WebHook and make calls into the Azure environment leveraging PowerShell.  For example, periodically making a modification to a Storage Account or a Virtual Machine.

Key Azure services that are part of their solution:  
- Function App

Portal/Service Catalog/UI or CLI/Scripting and ARM Templates used  
- Azure Portal
- PowerShell
- Azure CLI
- ARM Templates

Policy Definitions available/applicable in template form  
- No policies defined

### Provision Solution
Create Resource Group and Logic App using PowerShell and ARM Templates following the Deployment steps instructions provided above.
 - Template files are located in the following GitHub repository: https://github.com/cdwlabs/azure-services/tree/master/azure-functions

### Configure Solution
The following Azure CLI command(s) can configure a Function:
+ **az functionapp config**: This command configures the Azure Function App.
+ **az functionapp deployment**: This command configures the Continous Deployment capabilities for an Azure Function App.

#### Example: Configure an Azure Function to use a custom hostname
    az functionapp config hostname add --hostname www.yourdomain.com --name MyFunctionApp --resource-group MyResourceGroup

#### Example: Configure an Azure Function to use Continous Deployment with Containers
    az functionapp deployment container config --enable-cd true --name MyFunctionApp --resource-group MyResourceGroup

### Change/Update
The change/update process is the same as Configuring the Solution leveraging the following PowerShell Commands:
+ **az functionapp config**: This command configures the Azure Function App.
+ **az functionapp deployment**: This command configures the Continous Deployment capabilities for an Azure Function App.

#### Example: Configure an Azure Function to use a custom hostname
    az functionapp config hostname add --hostname www.yourdomain.com --name MyFunctionApp --resource-group MyResourceGroup

#### Example: Configure an Azure Function to use Continous Deployment with Containers
    az functionapp deployment container config --enable-cd true --name MyFunctionApp --resource-group MyResourceGroup

### Delete Hypothetical Solution
The solution can be deleted by deleting the resource group. This can be done via the Azure Portal or through PowerShell. The following PowerShell command will delete the Resource Group:
    
    Remove-AzResourceGroup -Name "ResourceGroupName"


Tags: AzureExpertMSP, Azure, AzureFunctions
