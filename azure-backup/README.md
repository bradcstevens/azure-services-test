<h1 class="large"><b>Azure Backup</b></h1>

This template deploys a basic Azure Backup solution with a single VM.

<h2 class="small"><b>Overview and deployed resources</b></h2>

Azure Backup is a backup solution which extends protection options to both Azure cloud-based resources and on-premise environments. Azure Backup can protect many VM types out of the box and with little OS administration required; backup policies can be easily applied at the VM level to multiple systems in a single pass. Azure Backup can also provide extra layers of protection for databases (including SQL and SAP HANA) and Azure File shares within the cloud. 

Azure Backup also provides Microsoft Azure Recovery Services (MARS) agents and Microsoft Azure Backup Server (MABS) installations to use for resources you'd like to protect in existing on-premise environments. MARS agents work in conjunction with a MABS system to keep a single local copy of a backup while moving older data up to the Recovery Services Vault for the configured retention length.

As is the case with other backup solutions, Azure Backup allows for multiple backup schedules and retention policies which administrators can use to fine-tune their recovery needs.

It is important to note that the Azure Backup solution should not be confused with the Azure Site Recovery (ASR) service. Azure Backup should be used in cases where granular file-level, directory, or system state recovery is required for the business. Azure Site Recovery should be used where specific Recovery Time Objectives and Recovery Point Objectives are defined for getting a business's production back online following a disaster scenario. In general, both are used as part of business continuity and disaster recovery (BCDR) planning for organizations, though each accomplish different aspects of the BCDR approach.

The following resources are deployed as part of the solution
Azure Backup

    Resource type 1A: Resource group to contain all Azure Backup-related resources
    Resource type 1B: A single VM to use for policy association to the Recovery Services Vault post-provisioning
    
    Resource type 2: Recovery Services Vault to use for policy creation and VM association
    
<h2><b>Prerequisites</b></h2>
1. Users will need the "AzureRm" PowerShell module installed to run the deployment commands. Users can install/import that module with the following commands:
<br></br>
Install-Module -Name AzureRm -AllowClobber -Force | Import-Module -Name AzureRm
<br></br>
2. If we wish to disable the "soft delete" option to allow for deletion of protected items from the Vault before the default 14 day window, then we must use the "Az.RecoveryServices" PowerShell module. Users can install/import that module with the following commands:
<br></br>
Install-Module -Name Az.RecoveryServices -AllowClobber -Force | Import-Module -Name Az.RecoveryServices

<h2><b>Deployment steps</b></h2>

<body>
1. Run the "msp-deploybackup.ps1" script from an administrative PowerShell session.
</body>
<h2 class="small"><b>How to connect to the solution</b></h2>
<h3 class="smaller"<b>Management</b></h3>

Management of Azure Backup policies, container/management server registrations, and protected items can all be done from Azure CLI, Azure PowerShell, and directly from the Azure Portal. MABS systems and MARS agents would be managed on a per-system basis if CDW also manages the customer's on-premise infrastructure. MABS is equivalent to System Center Data Protection Manager in most functionality, meaning management of a MABS system is very similar to what administrators would be familiar with for DPM.

<h3><b>How to manage the solution</b></h3>
Azure CLI, Azure PowerShell, and the Azure Portal can all be utilized to manage an Azure Backup solution.
<br></br>
Tags: AzureExpertMSP, Azure, AzureBackup
