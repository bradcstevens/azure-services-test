<h1 class="large"><b>Azure Files</b></h1>

This template deploys a basic Azure Files solution.

<h2 class="small"><b>Overview and deployed resources</b></h2>

Azure Files acts as a cloud-based file share (equivalent to an on-premise SMB share) with the added benefits of managed resiliency and globally accessible shares.

The following resources are deployed as part of the solution
Azure Files

    Resource type 1A: Resource group to contain all Azure Files-related resources
    Resource type 1B: Storage Account to house the File share
    Resource type 1C: The File Share itself

<h2><b>Prerequisites</b></h2>
1. Users will need the "Azure" PowerShell module installed to run these specific commmands. Users can install/Import that module with the following commands:
<br></br>
Install-Module -Name Azure -AllowClobber -Force | Import-Module -Name Azure

<h2><b>Deployment steps</b></h2>

<body>
1. Run the "msp-deployazurefiles.ps1" script from an administrative PowerShell session.
</body>
<h2 class="small"><b>How to connect to the solution</b></h2>
<h3 class="smaller"<b>Management</b></h3>

The command line option to connect to the created File Share itself is specific to the share being created and the intended drive letter on a client's workstation. This is a managed service, however, and there will be no virtual machine to connect to and manage the share. Management of the File Share's configurations will occur from Azure CLI, Azure PowerShell, or from within the Azure Portal.

<h3><b>How to manage the solution</b></h3>
Azure CLI, Azure PowerShell, and the Azure Portal can all be utilized to manage an Azure Files solution.
<br></br>
Tags: AzureExpertMSP, Azure, AzureFiles
