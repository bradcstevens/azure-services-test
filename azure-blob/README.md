<h1 class="large"><b>Azure Blob</b></h1>

This template deploys a basic Azure Blob solution.


<h2 class="small"><b>Overview and deployed resources</b></h2>

Azure Blob is a cloud-based storage solution which allows organizations to place unstructured data on a managed, higly durable, and highly resilient storage platform within the Azure cloud. Azure Blob storage provides routes for organizations to store data at varying price points depending on their specific needs, ranging from local region redundancy (read: a single data center) to multiple regions and availability zones at once (GZRS), with Standard (Hot and Cool possible with v2 Storage Accounts) and Premium performance levels available.

Azure Blob storage allows for standard understructured data (Blobs), Page blobs (like what backs OS and data disks in Azure), and Append blobs (primarily useful for log files). General Purpose v2 storage accounts can also host static web content from within the storage account.

The following resources are deployed as part of the solution
Azure Blob

    Resource type 1A: Resource group to contain all Azure Blob-related resources
    Resource type 1B: Storage Account(s) to house Blob containers

<h2><b>Prerequisites</b></h2>
1. Users will need the "Azure" PowerShell module installed to run the deployment commands. Users can install/import that module with the following commands:
<br></br>
Install-Module -Name Azure -AllowClobber -Force | Import-Module -Name Azure
<br></br>

<h2><b>Deployment steps</b></h2>

<body>
1. Run the "msp-deployblob.ps1" script from an administrative PowerShell session.
</body>
<h2 class="small"><b>How to connect to the solution</b></h2>
<h3 class="smaller"<b>Management</b></h3>

Users may upload files directly to an Azure Blob container from Azure CLI, Azure PowerShell, and directly from the Azure Portal. Management of the storage accounts and their Blob containers can occur from Azure CLI, Azure PowerShell, or from within the Azure Portal.

<h3><b>How to manage the solution</b></h3>
Azure CLI, Azure PowerShell, and the Azure Portal can all be utilized to manage an Azure Blob solution.
<br></br>
Tags: AzureExpertMSP, Azure, AzureBlob
