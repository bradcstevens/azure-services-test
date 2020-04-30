# SQL Database

This template deploys a SQL Database. The SQL Database is a stand alone database that can be connected to from inside an Azure tenat or publicly. SQL Databases are great for applications that require a single database. Microsoft manages patching and maintenance.

## Overview and deployed resources

The following resources are deployed as part of the solution

* SQL Database
* SQL Server

## Prerequisites

Decscription of the prerequistes for the deployment

1) Existing Resource Group

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

1) From the Azure Portal, navigate to your SQL database
2) On the Overview blade, copy the value for the Server name.

From SQL Server Management Studio:

1) click "Connect"
2) select "Database Engine..."
3) For Server name, paste the host value from above
4) For Authentication, choose "SQL Server Authentication"
5) For Login and password, enter the credentials you provided when setting up the SQL Server.

#### Management

1) Browse to the resource in Azure.
2) Select Configure
3) Select Compute Tier: Provisioned | Serverless
4) Change Configuration of the Compute Hardware

	For ServerLess:
1) Adjust Max vCores and Min vCores
2) Adjust Auto-Pause
3) Adjust Data max size

	For Provisioned:
1) Adjust Licensing Model
2) Adjust vCores
3) Adjust Data max size
