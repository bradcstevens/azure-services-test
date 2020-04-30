
# 3.3 - IaaS, PaaS, and SaaS Demonstration - Jaffe Law

This template deploys an Active Directory Domain Services IaaS VM solution. This solution deploys two VMs to be used for ADDS in Azure, using Microsoft best practices for disk caching.


## Sample overview and deployed resources

This includes four files, including template and parameter json files, a deployment powershell script, and a removal powershell script. It deploys the the resources outlined below. It will also deploy a Resource Group (RG) if it does not yet exist.


## The following resources are deployed as part of the solution:
  
### Compute-Infrastructure

+ **Azure Virtual Machines - Windows**: This solution deploys two Azure Virtual Machines.
+ **Azure Managed Disks**: For each of the above VMs, this solution is configured to deploy managed disks for the Windows OS as well as a non-cached data disk to be used for ADDS's SYSVOL and NTDS directories. The default configuration will deploy standard SSD volumes. The OS volumes are 127GB, while the data volumes are 32GB.
  
### Networking

+  **Virtual Network**: A single virtual network is deployed with this solution.
    - Default Network Ranges
        - VNet: 10.244.0.0/24
        - Subnet: 10.244.0.0/25

+  **Network Security Groups**: A single network security group is deployed, and shared across the VMs in this solution.

## Prerequisites

+ Owner or Contributor permissions on the Azure subscription.
+ Azure PowerShell module installed on the workstation being used to run this solution (https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-3.6.1)


## Deployment steps

1. Open the ADDSSolution.parameters.json file and modify the parameters to suit your needs. Make special note of the following parameters:
    - location
        - Region to which the resources will be deployed
    - addressPrefixes
        - Network range to be used for the virtual network
    - subnets > values > properties > addressPrefix
        - Network range of the subnet
    - virtualMachineSize
        - Size of the VMs to be deployed | Default is Standard_DS1_v2
    - adminUsername
        - Username of the local administrator account
    - adminPassword
        - Password of the local administrator account
        - After deploying, ensure that this password is removed from the parameters file.
    - [VM01\VM02]_virtualMachineName, [VM01\VM02]_networkInterfaceName, [VM01\VM02]_dataDisks, [VM01\VM02]_virtualMachineName
        - Names of the VM specific resources
    - [VM01\VM01]_dataDiskResources
        - Size of the data disk | Default is 32GB

2. Open the New-ADDSSolution.ps1 and modify the variables to successfully connect to your environment. Make special note of the following variables:

    - $Location="EastUS"
        - Specifies the region to which the Resource Group will be deployed.
    - $RG="MSP-MJS-ADDS01-EastUS"
        - Specify the name of the Resource Group.
    - $TenantID="de9231de-45f4-4325-ae07-8ae72052517e"
        - Specify your Azure Active Directory Tenant ID (aka Directory ID)
        - For more details:
            - https://docs.microsoft.com/en-us/onedrive/find-your-office-365-tenant-id
            - https://microsoft.github.io/AzureTipsAndTricks/blog/tip153.html
    - $SubscriptionID="dd2c542a-aeaf-4cef-9ccd-e89ae5864c3f"
        - Specify your Subscription ID
        - To find your Subscription ID:
            1) Login in to the Azure portal here: http://portal.azure.com
            2) On the left pane select "Subscriptions"
            3) Choose the subscription you want to check and click "Overview"
            4) Copy the subscription ID 
        - To find via PowerShell: https://docs.microsoft.com/en-us/powershell/module/servicemanagement/azure/get-azuresubscription?view=azuresmps-4.0.0
    - $Owner="Matt Sherwood"
        - Used for the Owner tag that will be configured on the Resource Group.
    - $Timestamp=(Get-Date -format "MM-dd-yyyy_HH-mm-ss")
        - Gathers timestamp data to be appended to the deployment name 
    - $DeploymentName = "ADDSInitialDeployment_" + $Timestamp
        - The name of the deployment object in Azure. As the deployment occurs, you will be able to view the status of the deployment by referencing the deployment name. To see deployment status, view the following article. https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deployment-history?tabs=azure-portal 

3. Run the New-ADDSSolution.ps1 script.



## Usage

### Connect

Solution can be viewed using Azure Portal, Azure PowerShell, or Azure CLI.

### Management

Solution can be managed via Azure Portal, Azure PowerShell, or Azure CLI.

## Notes

Feel free to contact Matt Sherwood if you have any questions about this solution.

`Tags: Azure, IaaS, Virtual Machine, Virtual Network, Network Security Group, Active Directory Domain Services`