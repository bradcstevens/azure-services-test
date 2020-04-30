<h1 class="large"><b>Azure Monitor and Log Analytics</b></h1>

This template deploys some basic structure to the Azure Monitor solution.

<h2 class="small"><b>Overview and deployed resources</b></h2>

Azure Monitor is Azure's centralized location for reviewing and manipulating metric and log data gathered from across Azure and registered on-premise resources and infrastructure. When combined with Log Analytics, Monitor can provide stakeholders in a customer's organization with important information about the performance and utilization of their resources, generate alerts and automated scaling actions when resources reach defined thresholds, and allow for proactive changes to important business resources to prevent production downtime.

The following resources are deployed as part of the solution
Azure Monitor with Log Analytics

    Resource type 1A: Resource group to contain the Azure Monitor-related resources
    Resource type 1B: Alerting rules, metrics, and Action Group(s)
    Resource type 1C: A Log Analytics workspace
    
    Resource type 2A: A virtual network
    Resource type 2B: A virtual machine residing in the vNet from 2A, with a single OS disk and one NIC.
    Resource type 2C: A Virtual Machine Scale Set to tie into Autoscale settings
    
    Resource type 3: A diagnostic storage account

<h2><b>Prerequisites</b></h2>
1. Users will need the "Azure" PowerShell module installed to run the deployment commands. Users can install/import that module with the following commands:
<br></br>
Install-Module -Name Azure -AllowClobber -Force | Import-Module -Name Azure
<br></br>
2. In order to appropriately generate components within the alerting configurations, we need to use the "Az.Monitor" PowerShell module to properly affect these changes. The standard "Azure" module does not contain all of the configuration options to create rule alerts in the Professional Services subscription used during deployment testing.

Users can install/import the Az.Monitor module with the following commands:
<br></br>
Install-Module -Name Az.Monitor -AllowClobber -Force | Import-Module -Name Az.Monitor
<h2><b>Deployment steps</b></h2>

<body>
1. Run the "msp-deploymonitor.ps1" script from an administrative PowerShell session.
</body>
<h2 class="small"><b>How to connect to the solution</b></h2>
<h3 class="smaller"<b>Management</b></h3>

Users may create rules, action groups, autoscale settings, and associated items used within Azure Monitor from Azure CLI, Azure PowerShell (with the Az.Monitor PowerShell module active), and directly from the Azure Portal. Management of the Azure Monitor configurations will occur from Azure CLI, Azure PowerShell, or from within the Azure Portal; report and dashboard viewing is limited to the Azure Portal, though reports can be sent out via email.

<h3><b>How to manage the solution</b></h3>
Azure CLI, Azure PowerShell, and the Azure Portal can all be utilized to manage components of the Azure Monitor solution.
<br></br>
Tags: AzureExpertMSP, Azure, AzureMonitor
