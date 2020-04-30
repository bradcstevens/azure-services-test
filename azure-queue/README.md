<h1 class="large"><b>Azure Queue</b></h1>

This template deploys a basic Azure Queue solution.

<h2 class="small"><b>Overview and deployed resources</b></h2>

Azure Queue is a component of Storage Accounts which allows for applications to utilize a decoupled, durable, secure message queue in between other aspects of a customer's application(s).

The following resources are deployed as part of the solution
Azure Queue

    Resource type 1A: Resource group to contain all Azure Queue-related resources
    Resource type 1B: Storage Account(s) to house the Queue(s)
    Resource type 1C: One or more Queues

<h2><b>Prerequisites</b></h2>
1. Users will need the "Azure" PowerShell module installed to run the deployment commands. Users can install/import that module with the following commands:
<br></br>
Install-Module -Name Azure -AllowClobber -Force | Import-Module -Name Azure
<br></br>

<h2><b>Deployment steps</b></h2>

<body>
1. Run the "msp-deployqueue.ps1" script from an administrative PowerShell session.
</body>
<h2 class="small"><b>How to connect to the solution</b></h2>
<h3 class="smaller"<b>Management</b></h3>

Users looking to manage Azure Queue may do so from Azure CLI, Azure PowerShell and directly from the Azure Portal. There is, however, little in the way of direct management one can do with a Queue once created, as the utilization of the Queue relies on how developers will tie it into their decoupled application(s). Developers can pull access keys for the Queue to tie ends of their applications into the Queue, though those specific actions fall outside of our Managed Services offerings.

<h3><b>How to manage the solution</b></h3>
Azure CLI, Azure PowerShell, and the Azure Portal can all be utilized to manage an Azure Queue solution. Management options for Queues themselves, however, are quite limited, as the Queue is more a means to an end for application development.
<br></br>
Tags: AzureExpertMSP, Azure, AzureQueue
