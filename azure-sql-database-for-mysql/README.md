# Azure SQL Database for MySQL

<
This template deploys a **Azure SQL Database for MySQL**. The **Azure SQL Database for MySQL** is a **description**

## Sample overview and deployed resources

Azure Database for MySQL provides fully managed, enterprise-ready community MySQL database as a service.  You get built-in high availability and dynamic scaling, helping you easily adjust to changes in customer demands.

## The following resources are deployed as part of the solution:

### Azure Resource Group

Description Resource Provider 1

+ **Resource type 1A**: The service used to provision resources in your Azure subscription


### Azure SQL Database for MySQL

Description Resource Provider 2

+ **Resource type 2A**: Azure Database for MySQL is a relational database service in the Microsoft cloud based on the MySQL Community Edition (available under the GPLv2 license) database engine, versions 5.6, 5.7, and 8.0.

## Prerequisites

Azure Subcription
Azure Powershell Version 1.0.0 or later

## Deployment steps

1.  Launch Powershell and sign in with your Azure creds.
2.  ./azuredeploy.ps1

## Usage

### Connect

Connect to the server using the mysql.exe command-line tool: 

mysql -h <servername.mysql.database.azure.com> -u myadmin<server-admin-login>@servername -p

#### Management

You can list, show, and update configuration parameters for an Azure Database for MySQL Server by using Azure CLI, the Azure command-line utility:

az mysql server firewall-rule create
az mysql server update
az mysql server show 
az group delete 

## Notes

Solution notes

`Tags: Tag1, Tag2, Tag3`