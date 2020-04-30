# Azure Data Migration Service

This template deploys an Azure Data Migration Service. The Azure Data Migration Service is an effecient way to migrate your data to the cloud. Whether moving to an Azure Database or a Managed Instance, Azure Data Migraton Service can assist with both offline (large number of databases, longer cutover window) and online (smaller number of databases and a smaller cutover window).

## Overview and deployed resources

The following resources are deployed as part of the solution

* Azure Data Migration Service
* Network Interface

## Prerequisites

Before an Azure Data Migration Service can be created, the following must exist:

1) Resource Group

## Deployment steps

1) Fork a copy of the repo
2) Install the AZ Powershell Modules
3) Open a Powershell session and type Connect-AzAccount
4) Provide valid credentials to your subscription
5) Navigate to the root of your repo
6) Navigate to the azure-services folder
7) Type the following command:
    .\deploy.ps1 subFolderName resourceGroupName

## Usage

### Connect

1) Sign in to the Azure Portal
2) Navigate to the new resource
3) Create a Project
4) Configure the data source, target and options
5) Run the Migration

#### Management
