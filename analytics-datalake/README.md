# Azure Data Lake Storage Gen2


This template deploys a **Azure Data Lake Storage Gen2**. The **Azure Data Lake Storage Gen2** is a **storage account that provides a set of capabilities dedicated to big data analytics. It is based on Blob storage.**

## Azure Data Lake Storage Gen2 overview and deployed resources

This solution provides a template for deploying blob storage with the Data Lake Gen2 option enabled. The template default performance/access tier is Standard/Hot. 

### Resource provider

Microsoft.Storage

+ **Resource type**: storageAccounts


## Prerequisites

Decscription of the prerequistes for the deployment

## Deployment steps

Modify the azuredeploy.parameters.json file to include the following for each customer: 

-location - Azure data center location

-storageAccountName - the name of the storage account

-accountType - 

-largeFileSharesState - "Enabled" or "Disabled"

-tags (such as owner)

From a PowerShell window, execute the deploy.ps1 script with the following parameters:

+ ServiceName    -  The name of the Azure service being deployed
+ ResourceGroup  -  The name of the resource group for deployment

```
.\deploy.ps1  ServiceName ResourceGroup
```
## Removal steps

From a PowerShell window, execute the remove.ps1 script with the following parameters:

+ ServiceName    -  The name of the Azure service being removed
+ ResourceGroup  -  The name of the resource group for removal

```
.\remove.ps1  <ServiceName> <ResourceGroup>

```
_Example:_

  .\remove.ps1 msp-sample-adl msp-adl-rg

  Will remove the service *msp-sample-adl* from the *msp-adl-rg* resource group.


### Connect

https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-integrate-with-azure-services?toc=%2fazure%2fstorage%2fblobs%2ftoc.json

### Management

https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-explorer
https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-directory-file-acl-powershell



`Tags: Azure Data Lake Gen2`