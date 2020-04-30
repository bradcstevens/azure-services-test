
# 2.1 (Migration) - Azure Data Box

This template deploys a resource group and storage account to stage for a DataBox deployment. 


## Sample overview and deployed resources
This includes four files, including template and parameter json files, a deployment powershell script, and a removal powershell script. It deploys the the resources outlined below. It will also deploy a Resource Group (RG) if it does not yet exist.


## The following resources are deployed as part of the solution:

### Storage

+ **Azure Storage Account**: This solution deploys a single Storage Account.

## Prerequisites

+ Owner or Contributor permissions on the Azure subscription.
+ Azure PowerShell module installed on the workstation being used to run this solution (https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-3.6.1)


## Deployment steps

1. Open the DataBoxSolution.parameters.json file and modify the parameters to suit your needs. Make special note of the following parameters:
    - location
        - Region to which the resources will be deployed
    - storageAccountName
        - Name of the storage account


2. Open the New-DataBoxStaging.ps1 and modify the variables to successfully connect to your environment. Make special note of the following variables:

    - $Location="Region"
        - Specifies the region to which the Resource Group will be deployed.
    - $RG="ResourceGroupName"
        - Specify the name of the Resource Group.
    - $TenantID="xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
        - Specify your Azure Active Directory Tenant ID (aka Directory ID)
        - For more details:
            - https://docs.microsoft.com/en-us/onedrive/find-your-office-365-tenant-id
            - https://microsoft.github.io/AzureTipsAndTricks/blog/tip153.html
    - $SubscriptionID="xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
        - Specify your Subscription ID
        - To find your Subscription ID via the Azure Portal:
            1) Login in to the Azure portal here: http://portal.azure.com
            2) On the left pane select "Subscriptions"
            3) Choose the subscription you want to use and click "Overview"
            4) Copy the subscription ID 
        - To find via Subscription ID via PowerShell: https://docs.microsoft.com/en-us/powershell/module/servicemanagement/azure/get-azuresubscription?view=azuresmps-4.0.0
    - $Owner="Owner Name"
        - Used for the Owner tag that will be configured on the Resource Group.
    - $Timestamp=(Get-Date -format "MM-dd-yyyy_HH-mm-ss")
        - Gathers timestamp data to be appended to the deployment name 
    - $DeploymentName = "DataBoxInitialDeployment_" + $Timestamp
        - The name of the deployment object in Azure. As the deployment occurs, you will be able to view the status of the deployment by referencing the deployment name. To see deployment status, view the following article. https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deployment-history?tabs=azure-portal 

3. Run the New-DataBoxStaging.ps1 script.


## Usage

### Connect
Solution can be viewed using Azure Portal, Azure PowerShell, or Azure CLI.

### Management
Solution can be managed via Azure Portal, Azure PowerShell, or Azure CLI.

## Notes
Feel free to contact Matt Sherwood if you have any questions about this solution.

## Example
### Hypothetical Use Case
CDW has worked with the client to setup their solution and is actively managing their environment.
- Customer had 20TB of data to migrate into a new Azure Storage Account within a week and didn’t have the bandwidth to upload over the network.
- This is a one-time migration.

Key Azure services that are part of their solution:  
- Azure Data Box
- Azure Storage Account

Portal/Service Catalog/UI or CLI/Scripting and ARM Templates used  
- Azure Portal
- PowerShell
- ARM Templates

Policy Definitions available/applicable in template form  
- No policies defined

### Diagram of Solution
See the following digram of the Azure DataBox solution
![alt-text](https://azurecomcdn.azureedge.net/cvt-07cd79bcf94c7abee51d2d07f52c7f42b4595e8b2fca2825cdbf8d1bd6912e4b/images/page/services/databox/diagram.png)

### Provision Solution
- Create Resource Group with Storage Account using PowerShell and ARM Templates
    - Template files are located in the following GitHub repository: https://github.com/cdwlabs/azure-services/tree/master/azure-data-box 
- Use Azure Portal to order a new Azure Data Box
- Schedule ticket to follow-up with customer after DataBox order is received
    - Follow-up must include the following tasks:
        - Assist customer with getting data onto the DataBox device
        - Guide customer through data validation process
        - Provide customer with instructions and guidance to return the device

### Configure Solution
The solution was configued using the following processes
- There are no configurations available for Azure Data Box Disk. Once the order has been placed, there is nothing else that can be configured

### Change/Update
The change/update process is as follows
- Once the disk has been received, the customer will follow instructions listed under ResourceName > General > Quickstart.
- To cancel the order, you can follow the documentation here:
    - https://docs.microsoft.com/en-us/azure/databox/data-box-portal-admin#cancel-an-order
- To clone the order, you can follow the documentation here:
    - https://docs.microsoft.com/en-us/azure/databox/data-box-portal-admin#clone-an-order
- To delete the order, you can follow the documentation here:
    - https://docs.microsoft.com/en-us/azure/databox/data-box-portal-admin#delete-order

### Delete Hypothetical Solution
The solution is deleted by using the following process
- The solution can be deleted by deleting the resource group. This can be done via the Azure Portal or through PowerShell. The following provides the process to delete the solution using PowerShell.
    - Template files are located in the following GitHub repository: https://github.com/cdwlabs/azure-services/tree/master/azure-data-box

### References
- What is Azure Data Box Disk? 
    - https://docs.microsoft.com/en-us/azure/databox/data-box-disk-overview
- Quickstart: Deploy Azure Data Box Disk using the Azure portal
    - https://docs.microsoft.com/en-us/azure/databox/data-box-disk-quickstart-portal





`Tags: Azure, Storage Account, StorageAccount, DataBox Disk, DataBoxDisk`