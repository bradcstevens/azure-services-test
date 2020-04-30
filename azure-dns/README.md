<h1 class="large"><b>Azure DNS</b></h1>

This template deploys a basic Azure DNS solution.

<h2 class="small"><b>Overview and deployed resources</b></h2>

Azure DNS is a cloud-based DNS solution for both public facing resources and for private resources internal to a tenant's virtual network(s). Similar in structure to traditional DNS management, Azure DNS provides management for standard DNS record types across configured DNS zones to simplify name management of a tenant's resources across the Azure cloud.

The following resources are deployed as part of the solution
Azure DNS

    Resource type 1A: Resource group to contain all Azure DNS-related resources
    Resource type 1B: An Azure DNS zone (public)
    Resource type 1C: Zone records in the DNS zone

<h2><b>Prerequisites</b></h2>
1. Users will need the "Azure" PowerShell module installed to run the deployment commands. Users can install/import that module with the following commands:
<br></br>
Install-Module -Name Azure -AllowClobber -Force | Import-Module -Name Azure
<br></br>

<h2><b>Deployment steps</b></h2>
<body>
1. Run the "msp-deployarchive.ps1" script from an administrative PowerShell session.
</body>
<h2 class="small"><b>How to connect to the solution</b></h2>
<h3 class="smaller"<b>Management</b></h3>

Users may create/delete zones and add/update/remove zone records from Azure CLI, Azure PowerShell, and directly from the Azure Portal. Management of the Azure DNS configurations will occur from Azure CLI, Azure PowerShell, or from within the Azure Portal.

<h3><b>How to manage the solution</b></h3>
Azure CLI, Azure PowerShell, and the Azure Portal can all be utilized to manage an Azure DNS solution.
<br></br>
Tags: AzureExpertMSP, Azure, AzureDNS
