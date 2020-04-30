# Synapse Analytics

This template deploys a Synapse Analytics Server

## Overview and deployed resources

The following resources are deployed as part of the solution

* Synapse Analytics
* SQL Server

## Prerequisites

Decscription of the prerequistes for the deployment

1) Existing Resource Group
2) Database Name

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

Determine your Server name:

1) From the Azure Portal, navigate to your Synapse Analystics
2) On the Overview blade, copy the value for the Server name.

From SQL Server Management Studio:

1) click "Connect"
2) select "Database Engine..."
3) For Server name, paste the host value from above
4) For Authentication, choose "SQL Server Authentication"
5) For Login and password, enter the credentials you provided when setting up the SQL Server.

#### Management

Browse to the resource in Azure.

## Notes

Solution notes