# Azure Logic Apps

This template deploys an Azure Logic App that provides an HTTP Body response when executed.

## Overview 

Azure Logic Apps is a cloud service that helps you schedule, automate, and orchestrate tasks, business processes, and workflows when you need to integrate apps, data, systems, and services across enterprises or organizations. Logic Apps simplifies how you design and build scalable solutions for app integration, data integration, system integration, enterprise application integration (EAI), and business-to-business (B2B) communication, whether in the cloud, on premises, or both.

## Deployed Resources
The following resources are deployed as part of the solution:

+ **Logic App**: Logic App that responds with an HTTP Body when triggered

## Prerequisites
Users will need the "Azure" PowerShell module installed to run the deployment commands. Users can install/import that module with the following commands:

    Install-Module -Name Az -AllowClobber -Force | Import-Module -Name Az

## Deployment steps
1. Open "AzureLogicAppsDeploy.ps1" and modify the name of the Resource Group and/or Location you would like the Logic App deployed to.
2. Open "azuredeploy.parameters.json" and provide a value for the Logic App Name within the LogicAppName parameter.
3. Run the "AzureLogicAppsDeploy.ps1" script from an administrative PowerShell session.

## Example
### Hypothetical Use Case
Customer has a requirement about being able to call an HTTP Webook and retrieving a custom HTTP response that can then be ingested into various solutions.  

Key Azure services that are part of their solution:  
- Logic Apps

Portal/Service Catalog/UI or CLI/Scripting and ARM Templates used  
- Azure Portal
- PowerShell
- ARM Templates

Policy Definitions available/applicable in template form  
- No policies defined

### Diagram of Solution
See the following diagram of a Logic App solution that can be optionally front-ended by API Management to provide certain API restrictions when calling a Logic App:

![alt-text](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/enterprise-integration/_images/simple-enterprise-integration.png)

### Provision Solution
Create Resource Group and Logic App using PowerShell and ARM Templates following the Deployment steps instructions provided above.
 - Template files are located in the following GitHub repository: https://github.com/cdwlabs/azure-services/tree/master/azure-logic-apps 

### Configure Solution
The following PowerShell command(s) can configure a Logic App:
+ **Set-AzLogicApp**: This command configures the Logic App.

#### Example: Re-Configure a Logic App
    Set-AzLogicApp -ResourceGroupName "ResourceGroupNAme" -Name "LogicAppName" -State "Enabled" -AppServicePlan "AppServicePlanName" -DefinitionFilePath "d:\workflows\Definition17.json" -ParameterFilePath "d:\workflows\Parameters17.json"

### Change/Update
The change/update process is the same as Configuring the Solution leveraging the following PowerShell Commands:
+ **Set-AzNotificationHubsNamespace**: This command configures the Notification Hub Namespace.
+ **Set-AzLogicApp**: This command configures the Logic App.

#### Example: Re-Configure a Logic App
    Set-AzLogicApp -ResourceGroupName "ResourceGroupNAme" -Name "LogicAppName" -State "Enabled" -AppServicePlan "AppServicePlanName" -DefinitionFilePath "d:\workflows\Definition17.json" -ParameterFilePath "d:\workflows\Parameters17.json"

### Delete Hypothetical Solution
The solution can be deleted by deleting the resource group. This can be done via the Azure Portal or through PowerShell. The following PowerShell command will delete the Resource Group:
    
    Remove-AzResourceGroup -Name "ResourceGroupName"


Tags: AzureExpertMSP, Azure, AzureLogicApps
