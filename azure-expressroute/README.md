# Azure ExpressRoute

This template deploys an ExpressRoute Circuit.

## Overview

Azure ExpressRoute is leveraged to create private connections between Azure datacenters and infrastructure on your premises or in a colocation environment. ExpressRoute connections don't go over the public Internet, and they offer more reliability, faster speeds, and lower latencies than typical Internet connections. In some cases, using ExpressRoute connections to transfer data between on-premises systems and Azure can give you significant cost benefits.

With ExpressRoute, establish connections to Azure at an ExpressRoute location, such as an Exchange provider facility, or directly connect to Azure from your existing WAN network, such as a multiprotocol label switching (MPLS) VPN, provided by a network service provider.

## Deployed Resources
The following resources are deployed as part of the solution:

+ **ExpressRoute Circuit**: ExpressRoute Circuit deployed in the Resource Group specified

## Prerequisites
Users will need the "Azure" PowerShell module installed to run the deployment commands. Users can install/import that module with the following commands:

    Install-Module -Name Az -AllowClobber -Force | Import-Module -Name Az
    
## Deployment steps
1. Open "AzureExpressRouteDeploy.ps1" and modify the name of the Resource Group and/or Location you would like the ExpressRoute Circuit deployed to.
2. Open "azuredeploy.parameters.json" and provide a value for the following:
   1. ExpressRoute Circuit Name within the circuitName parameter.
   2. Service Provider Name within the serviceProviderName parameter.
   3. Peering Location within the peeringLocation parameter.
   4. Bandwidth in Mbps within the bandwidthInMbps parameter.
   5. SKU Tier (Standard or Premium) within the sku_tier parameter.
   6. SKU Family (Metered or Unlimited) within the sku_family parameter.
3. Run the "AzureExpressRouteDeploy.ps1" script from an administrative PowerShell session.

## Example
### Hypothetical Use Case
Customer has strict requirements of routing certain traffic across private connections to ensure this traffic does not go over the network.  This traffic must offer higher security, reliability, and speeds with lower latencies than typical connections over the internet.

Key Azure services that are part of their solution:  
- ExpressRoute Circuit

Portal/Service Catalog/UI or CLI/Scripting and ARM Templates used  
- Azure Portal
- PowerShell
- ARM Templates

Policy Definitions available/applicable in template form  
- No policies defined

### Diagram of Solution
See the following diagram of the ExpressRoute solution:

![alt-text](https://docs.microsoft.com/en-us/azure/expressroute/media/expressroute-introduction/expressroute-connection-overview.png)

### Provision Solution
Create Resource Group and ExpressRoute Circuit using PowerShell and ARM Templates following the Deployment steps instructions provided above.
 - Template files are located in the following GitHub repository: https://github.com/cdwlabs/azure-services/tree/master/azure-expressroute 

### Configure Solution
The following PowerShell command(s) can configure an ExpressRoute Circuit's Peering Configuration:
+ **Set-AzExpressRouteCircuitPeeringConfig**: This command configures the Peering Configuration of an ExpressRoute Circuit.

#### Example: Configure Microsoft Peering on an ExpressRoute Circuit
    $ckt = Get-AzExpressRouteCircuit -Name "ExpressRouteARMCircuit" -ResourceGroupName "ExpressRouteResourceGroup"

    Add-AzExpressRouteCircuitPeeringConfig -Name "MicrosoftPeering" -ExpressRouteCircuit $ckt -PeeringType MicrosoftPeering -PeerASN 100 -PeerAddressType IPv4 -PrimaryPeerAddressPrefix "123.0.0.0/30" -SecondaryPeerAddressPrefix "123.0.0.4/30" -VlanId 300 -MicrosoftConfigAdvertisedPublicPrefixes "123.1.0.0/24" -MicrosoftConfigCustomerAsn 23 -MicrosoftConfigRoutingRegistryName "ARIN"

#### Example: Configure Private Peering on an ExpressRoute Circuit
    $ckt = Get-AzExpressRouteCircuit -Name "ExpressRouteARMCircuit" -ResourceGroupName "ExpressRouteResourceGroup"

    Add-AzExpressRouteCircuitPeeringConfig -Name "AzurePrivatePeering" -ExpressRouteCircuit $ckt -PeeringType AzurePrivatePeering -PeerASN 100 -PrimaryPeerAddressPrefix "10.0.0.0/30" -SecondaryPeerAddressPrefix "10.0.0.4/30" -VlanId 200

### Change/Update
The following command(s) can change/update an ExpressRoute Circuit:
+ **Set-AzExpressRouteCircuit**: This command configures the ExpressRoute Circuit.

#### Example: Enable ExpressRoute Premium Addon
    $ckt = Get-AzExpressRouteCircuit -Name "ExpressRouteARMCircuit" -ResourceGroupName "ExpressRouteResourceGroup"

    $ckt.Sku.Tier = "Premium"
    $ckt.sku.Name = "Premium_MeteredData"

    Set-AzExpressRouteCircuit -ExpressRouteCircuit $ckt

#### Example: Resize the Circuit
    $ckt = Get-AzExpressRouteCircuit -Name "ExpressRouteARMCircuit" -ResourceGroupName "ExpressRouteResourceGroup"

    $ckt.ServiceProviderProperties.BandwidthInMbps = 1000

    Set-AzExpressRouteCircuit -ExpressRouteCircuit $ckt

### Delete Hypothetical Solution
The solution can be deleted by deleting the resource group. This can be done via the Azure Portal or through PowerShell. The following PowerShell command will delete the Resource Group:
    
    Remove-AzResourceGroup -Name "ResourceGroupName"


Tags: AzureExpertMSP, Azure, AzureExpressRoute
