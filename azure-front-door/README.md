# Azure FrontDoor

This template deploys two Azure Web App Sites behind Azure Front Door in Active/Passive.

## Overview

Azure Front Door enables you to define, manage, and monitor the global routing for your web traffic by optimizing for best performance and instant global failover for high availability. With Front Door, you can transform your global (multi-region) consumer and enterprise applications into robust, high-performance personalized modern applications, APIs, and content that reaches a global audience with Azure.

Front Door works at Layer 7 or HTTP/HTTPS layer and uses anycast protocol with split TCP and Microsoft's global network for improving global connectivity. So, per your routing method selection in the configuration, you can ensure that Front Door is routing your client requests to the fastest and most available application backend. An application backend is any Internet-facing service hosted inside or outside of Azure. Front Door provides a range of traffic-routing methods and backend health monitoring options to suit different application needs and automatic failover models. Similar to Traffic Manager, Front Door is resilient to failures, including the failure of an entire Azure region.

## Deployed Resources
The following resources are deployed as part of the solution:

+ **Web App**: Two Azure Web Apps in separate Resource Groups
+ **App Service Plan**: Two Azure App Service Plans in their corresponding Web App's Resource Groups
+ **Front Door**: App Service Plan using the Consumption Model for our Function App to operate against

## Prerequisites
Users will need the "Azure" PowerShell module installed to run the deployment commands. Users can install/import that module with the following commands:

    Install-Module -Name Az -AllowClobber -Force | Import-Module -Name Az

## Deployment steps

### Website 1
1. Open Website 1 Folder.
2. Open "AzureWebsite1Deploy.ps1" and modify the name of the Resource Groups and/or Locations you would like the Website1 Web App deployed to.
3. Open "azuredeploy.parameters.json" and provide the WebApp a name for Website1.
4. Run the "AzureWebsite1Deploy.ps1" script from an administrative PowerShell session.
5. Note the Website FQDN from the ARM Template Output.
    
### Website 2
1. Open Website 2 Folder.
2. Open "AzureWebsite2Deploy.ps1" and modify the name of the Resource Groups and/or Locations you would like the Website2 Web App deployed to.<br>
3. Open "azuredeploy.parameters.json" and provide the WebApp a name for Website2.
4. Run the "AzureWebsite2Deploy.ps1" script from an administrative PowerShell session.
5. Note the Website FQDN from the ARM Template Output.

### Front Door
1. Open FrontDoor Folder.
2. Open "AzureFrontDoorDeploy.ps1" and modify the name of the Resource Groups and/or Locations you would like the Front Door deployed to.
3. Open "azuredeploy.parameters.json" and provide the Website FQDN Values from Website1 as backendAddress1.
4. Open "azuredeploy.parameters.json" and provide the Website FQDN Values from Website2 as backendAddress2.
5. Run the "AzureFrontDoorDeploy.ps1" script from an administrative PowerShell session.

## Example
### Hypothetical Use Case
Customer has a requirement about having a website deployed into two separate Azure Regions with a globally resilient solution providing Active/Passive Resilience across the two websites in case one of their Web Apps go offline whether due to a Web App issue or a service issue within a given region.

Key Azure services that are part of their solution:  
- Web App
- App Service Plan
- Front Door

Portal/Service Catalog/UI or CLI/Scripting and ARM Templates used  
- Azure Portal
- PowerShell
- ARM Templates

Policy Definitions available/applicable in template form  
- No policies defined

### Diagram of Solution
See the following diagram of a Front Door solution that can distribute traffic to Azure Web App Websites that are located in different locations:

![alt-text](https://miro.medium.com/max/2652/1*o-aTgaOlYQo-i9MvY7vNmA.png)

### Provision Solution
Create Resource Group and Logic App using PowerShell and ARM Templates following the Deployment steps instructions provided above.
 - Template files are located in the following GitHub repository: https://github.com/cdwlabs/azure-services/tree/master/azure-front-door

### Configure Solution
The following PowerShell command(s) can configure a Function:
+ **Set-AzFrontDoor**: This command configures the Azure Front Door.

#### Example: Configure routing rules, backend pools, frontend endpoints, Load Balancing Settings, Health Probe Settings, or Backend Pool Settings.
    Set-AzFrontDoor -Name "frontDoor1" -ResourceGroupName "resourceGroup1" -RoutingRule $routingrule1 -BackendPool $backendpool1 -FrontendEndpoint $frontendEndpoint1 -LoadBalancingSetting $loadBalancingSetting1 -HealthProbeSetting $healthProbeSetting1 -BackendPoolsSetting $backendPoolsSetting1

### Change/Update
The change/update process is the same as Configuring the Solution leveraging the following PowerShell Commands:
+ **Set-AzFrontDoor**: This command configures the Azure Front Door.

#### Example: Configure routing rules, backend pools, frontend endpoints, Load Balancing Settings, Health Probe Settings, or Backend Pool Settings.
    Set-AzFrontDoor -Name "frontDoor1" -ResourceGroupName "resourceGroup1" -RoutingRule $routingrule1 -BackendPool $backendpool1 -FrontendEndpoint $frontendEndpoint1 -LoadBalancingSetting $loadBalancingSetting1 -HealthProbeSetting $healthProbeSetting1 -BackendPoolsSetting $backendPoolsSetting1

### Delete Hypothetical Solution
The solution can be deleted by deleting the resource group. This can be done via the Azure Portal or through PowerShell. The following PowerShell command will delete the Resource Group:
    
    Remove-AzResourceGroup -Name "ResourceGroupName"


Tags: AzureExpertMSP, Azure, AzureFrontDoor
