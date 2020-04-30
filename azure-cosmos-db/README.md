# Azure Cosmos DB

<
This template deploys an **Azure Cosmos DB**.  **Azure Cosmos DB is Microsoft's globally distributed, multi-model database service. With a click of a button, Cosmos DB enables you to elastically and independently scale throughput and storage across any number of Azure regions worldwide.**

## Sample overview and deployed resources

Cosmos DB is a fully managed service, you no longer need to manage and operate complex multi datacenter deployments and upgrades of your database software, pay for the support, licensing, or operations or have to provision your database for the peak workload.

## The following resources are deployed as part of the solution:

### Azure Resource Group

Description Resource Provider 1

+ **Resource type 1A**: The service used to provision resources in your Azure subscription

### Azure Cosmos DB

Description Resource Provider 2

+ **Resource type 2A**: Azure Cosmos DB

## Prerequisites

Azure Subcription
Azure Powershell Version 1.0.0 or later

## Deployment steps

1.  Launch Powershell and sign in with your Azure creds.
2.  ./azureDeploy-cosmosdb.ps1

## Usage

### Connect

#### Management

You can list, show, and update configuration parameters for an Azure Cosmos DB by using Azure CLI, the Azure command-line utility:

az group create
az cosmosdb create 
az cosmosdb sql database create
az cosmosdb sql container create
az group delete

## Notes

Solution notes

`Tags: Tag1, Tag2, Tag3`