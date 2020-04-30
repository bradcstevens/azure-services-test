# Virtual Machine Scale Set Apache Web Server on Ubuntu

Solution deploys a Virtual Machine Scale Set via Azure DevOps pipeline. Azure DevOps pipeline pulls a Docker Container Azure CLI image nested and sources ARM templates as well as installation scripts from SAS Key and Anonymous Access containers in an Azure Storage Account. 

## Key technologies used

- [CDW Professional Services Azure Subscription](https://portal.azure.com/#@cdw.onmicrosoft.com/resource/subscriptions/dd2c542a-aeaf-4cef-9ccd-e89ae5864c3f/overview)
- [CDW Labs Github Organization](https://github.com/cdwlabs)
- [Azure DevOps Organization](https://dev.azure.com/azure-services/azure-vmss-public-web-server)

# Solution and steps

There were three primary pieces to the solution: 

* Authenticates to Azure via Service Principal
* Uses Microsoft Container Registry Docker Image for Azure CLI
* Deploys a Virtual Machine Scale Set from Azure Resource Manager Nested Templates

## Developer prerequisites 

1. Install a text-editor or an Integrated Development Environment. 
2. Obtain a [GitHub](http://github.com) account.
3. Obtain access to [cdwlabs](https://github.com/cdwlabs) GitHub Organization. 
4. Obtain access to the CDW Professional Services [Azure subscription](http://azure.com) to manage the deployments in Azure.
5. Obtain a access to the Azure Services [Azure DevOps Organization](https://dev.azure.com/azure-services/azure-vmss-public-web-server).

# Technical delivery

The entire solution involved multiple technologies. This diagram shows the high-level architecture that is explained in each of the following sub-sections. 

 ![Architecture Diagram](/images/Architecture.png)

## Azure Services

### Resource Groups
* msp-artifact-storage-accounts
* msp-vmss-public-web-server

### Storage Account
* Generation 2
* Deploys an Azure Storage Account
* Creates two Azure Storage Account Containers
    * nested-templates
        * SAS Key Access
    * scripts
        * Anonymous Access