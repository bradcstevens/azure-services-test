<h1 class="large"><b>Azure Archive</b></h1>

This template deploys a basic Azure Archive blob solution.

<h2 class="small"><b>Overview and deployed resources</b></h2>

Azure Archive is a Blob storage tier (at the container level) which places unstructured data in an extremely low cost, highly durable storage platform within the Azure cloud. Archive tiered storage is best meant for storing older unstructured data which an organization must store in the long term for various purposes. As such, the files are still accessible, but files have a "rehydration" (read: pulled from the "archive") window before users can access the files. This storage tier, while incredibly cost effective for retention purposes, is not intended for use with regularly or infrequently accessed data; that's where Blob Storage's Hot and Cool access tiers come into play.

The following resources are deployed as part of the solution
Azure Archive

    Resource type 1A: Resource group to contain all Azure Archive-related resources
    Resource type 1B: General Purpose v2 Storage Account(s) to house the Archive containers
    Resource type 1C: Containers within the Storage Account(s)

<h2><b>Prerequisites</b></h2>
1. Users will need the "Azure" PowerShell module installed to run the deployment commands. Users can install/import that module with the following commands:
<br></br>
Install-Module -Name Azure -AllowClobber -Force | Import-Module -Name Azure
<br></br>
2. In order to change access tiers across larger swathes of files already in a General Purpose v2 or Blob Storage storage account, we need to use the "Az.Storage" PowerShell module to properly affect these changes. The "Azure.Storage" module does not contain an option to specifiy the "Archive" tier when uploading files over PowerShell to a container.

Users can install/import the Az.Storage module with the following commands:
<br></br>
Install-Module -Name Az.Storage -AllowClobber -Force | Import-Module -Name Az.Storage
<h2><b>Deployment steps</b></h2>

<body>
1. Run the "msp-deployarchive.ps1" script from an administrative PowerShell session.
</body>
<h2 class="small"><b>How to connect to the solution</b></h2>
<h3 class="smaller"<b>Management</b></h3>

Users may upload files directly to an Azure Archive container from Azure CLI, Azure PowerShell (with the Az.Storage PowerShell module active), and directly from the Azure Portal. Management of the Archive storage configurations will occur from Azure CLI, Azure PowerShell, or from within the Azure Portal.

<h3><b>How to manage the solution</b></h3>
Azure CLI, Azure PowerShell, and the Azure Portal can all be utilized to manage an Azure Archive solution.
<br></br>
Tags: AzureExpertMSP, Azure, AzureArchive
