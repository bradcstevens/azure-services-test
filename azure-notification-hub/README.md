# Azure Notification Hub

This template deploys an Azure Notification Hub.

## Overview

Azure Notification Hubs provide an easy-to-use and scaled-out push engine that enables you to send notifications to any platform (iOS, Android, Windows, etc.) from any back-end (cloud or on-premises). Notification Hubs works great for both enterprise and consumer scenarios. Here are a few example scenarios:

* Send breaking news notifications to millions with low latency.
* Send location-based coupons to interested user segments.
* Send event-related notifications to users or groups for media/sports/finance/gaming applications.
* Push promotional contents to applications to engage and market to customers.
* Notify users of enterprise events such as new messages and work items.
* Send codes for multi-factor authentication.

## Deployed Resources
The following resources are deployed as part of the solution:

+ **Notification Hub Namespace**: This solution deploys a single Notification Hub Namespace.
+ **Notification Hub**: This solution deploys a single Notification Hub within the Notification Hub Namespace.

## Prerequisites
Users will need the "Azure" PowerShell module installed to run the deployment commands. Users can install/import that module with the following commands:

    Install-Module -Name Az -AllowClobber -Force | Import-Module -Name Az
    
## Deployment steps
1. Open "AzureNotificationHub.ps1" and modify the name of the Resource Groups and/or Locations you would like the Notification Hub Namespace to be created in.
2. Open "azuredeploy.parameters.json" and provide a value for the Notification Hub Namespace Name within the namespaceName parameter.
3. Run the "AzureNotificationHub.ps1" script from an administrative PowerShell session.

## Example
### Hypothetical Use Case
Customer is developing an iOS application and has a requirement to send notifications to iOS endpoints when their application is in the background.

Key Azure services that are part of their solution:  
- Azure Notification Hub Namespace
- Azure Notification Hub

Portal/Service Catalog/UI or CLI/Scripting and ARM Templates used  
- Azure Portal
- PowerShell
- ARM Templates

Policy Definitions available/applicable in template form  
- No policies defined

### Diagram of Solution
See the following diagram of the Azure Notification Hub solution:

![alt-text](https://docs.microsoft.com/en-us/azure/notification-hubs/media/notification-hubs-overview/registration-diagram.png)

### Provision Solution
Create Resource Group, Notification Hub Namespace, and Notification Hub using PowerShell and ARM Templates following the Deployment steps instructions provided above.
 - Template files are located in the following GitHub repository: https://github.com/cdwlabs/azure-services/tree/master/azure-notification-hub 

### Configure Solution
The following PowerShell command(s) can change/update a Notification Hub Namespace and Notification Hub:
+ **Set-AzNotificationHubsNamespace**: This command configures the Notification Hub Namespace.
+ **Set-AzNotificationHub**: This command configures the Notification Hub.

#### Example: Disable a Notification Hub Namespace
    Set-AzNotificationHubsNamespace -Namespace "NamespaceName" -Location "RegionName" -ResourceGroup "ResourceGroupName" -State "Disabled"

#### Example: Modify the property values for a notification Hub
    Set-AzNotificationHub -Namespace "NamespaceName" -ResourceGroup "ResourceGroupName" -InputFile "C:\Configuration\Hubs.json"

### Change/Update
The change/update process is the same as Configuring the Solution leveraging the following PowerShell Commands:
+ **Set-AzNotificationHubsNamespace**: This command configures the Notification Hub Namespace.
+ **Set-AzNotificationHub**: This command configures the Notification Hub.

#### Example: Disable a Notification Hub Namespace
    Set-AzNotificationHubsNamespace -Namespace "NamespaceName" -Location "RegionName" -ResourceGroup "ResourceGroupName" -State "Disabled"

#### Example: Modify the property values for a notification Hub
    Set-AzNotificationHub -Namespace "NamespaceName" -ResourceGroup "ResourceGroupName" -InputFile "C:\Configuration\Hubs.json"

### Delete Hypothetical Solution
The solution can be deleted by deleting the resource group. This can be done via the Azure Portal or through PowerShell. The following PowerShell command will delete the Resource Group:
    
    Remove-AzResourceGroup -Name "ResourceGroupName"


Tags: AzureExpertMSP, Azure, AzureNotificationHub
