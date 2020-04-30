
# 3.3 - IaaS, PaaS, and SaaS Demonstration - Encino Energy

This template deploys a multi-node VM solution. This solution deploys servers to be used for an ArcGIS environment in Azure.


## Sample overview and deployed resources

This includes four files, including template and parameter json files, a deployment powershell script, and a removal powershell script. It deploys the the resources outlined below. It will also deploy a Resource Group (RG) if it does not yet exist.


## The following resources are deployed as part of the solution:
  
### Compute-Infrastructure

+ **Azure Virtual Machines - Windows**: This solution deploys five Azure Virtual Machines.
    - Four Windows Server 2016 servers to be used for applications
    - One Windows Server 2016 with SQL 2017 server to be used for the application database.
+ **Azure Managed Disks**: For each of the above VMs, this solution is configured to deploy managed disks for the Windows OS as well as data disk to be used for applications. The default configuration will deploy standard SSD volumes. The default OS and Data volumes are 127GB.
  
### Networking

+  **Virtual Network**: A single virtual network is deployed with this solution.
    - Default Network Ranges
        - VNet: 10.2.0.0/24
        - Subnet: 10.2.0.0/25
+  **Network Security Groups**: A single network security group is deployed, and shared across the VMs in this solution.

### Management
+ **Automation Account**: A single automation account. The customer requested an automation account to be included in this deployment in effort to automate start-up and shut-down VMs based on a schedule.

## Prerequisites

+ Owner or Contributor permissions on the Azure subscription.
+ Azure PowerShell module installed on the workstation being used to run this solution (https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-3.6.1)


## Deployment steps

1. Open the ArcGisSolution.parameters.json file and modify the parameters to suit your needs. Make special note of the following parameters:
    - location
        - Region to which the resources will be deployed
    - addressPrefixes
        - Network range to be used for the virtual network
    - subnets > values > properties > addressPrefix
        - Network range of the subnet
    - virtualMachineSize
        - Size of the VMs to be deployed | Default is Standard_DS1_v2
    - DB01_virtualMachineSize
        - Size of the Database VM to be deployed | Default is Standard_DS11_v2
    - adminUsername
        - Username of the local administrator account
    - adminPassword
        - Password of the local administrator account
        - After deploying, ensure that this password is removed from the parameters file.
    - [VmName]_virtualMachineName, [VmName]_networkInterfaceName, [VmName]_dataDisks, [VmName]_virtualMachineName
        - Names of the VM specific resources
    - [VmName]_dataDiskResources
        - Size of the data disk | Default is 32GB

2. Open the New-ADDSSolution.ps1 and modify the variables to successfully connect to your environment. Make special note of the following variables:

    - $Location="EastUS"
        - Specifies the region to which the Resource Group will be deployed.
    - $RG="MSP-MJS-ArcGIS01-EastUS"
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
    - $DeploymentName = "ArcGisInitialDeployment_" + $Timestamp
        - The name of the deployment object in Azure. As the deployment occurs, you will be able to view the status of the deployment by referencing the deployment name. To see deployment status, view the following article. https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deployment-history?tabs=azure-portal 

3. Run the New-ArcGisSolution.ps1 script.



## Usage

### Connect

Solution can be viewed using Azure Portal, Azure PowerShell, or Azure CLI.

### Management

Solution can be managed via Azure Portal, Azure PowerShell, or Azure CLI.

## Notes

Feel free to contact Matt Sherwood if you have any questions about this solution.

`Tags: Azure, IaaS, Virtual Machine, Virtual Network, Network Security Group, Active Directory Domain Services, Automation Accounts, ArcGIS`