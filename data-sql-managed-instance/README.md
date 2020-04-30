# Managed Instance

This template deploys a Managed Instance (MI). The MI is 1 or more databases contained in an instance of SQL Server. This solution is PaaS and therefore the file sytem and the operating system are obfuscated from the user. Patching of the host as well as backups are maintained automatically by Azure. MI maintains a high level of feature parity with a traditional installation of SQL server.

## Overview and deployed resources

The following resources are deployed as part of the solution

* Managed Instance
* Route Tables
* Network Security Group

## Prerequisites

Before an MI can be created, the following must already exist:

1) Resource Group
2) VNET
3) subnet

## Requirements

The following items must be provided in the form of parameters placed in the parameters file:

 1) Managed Instance Name
 2) Administrator Login
 3) Administrator Password
 4) VNET
 5) subnet
 6) Location
 7) SKU Name
 8) SKU Edition
 9) Storage Size In GB
10) vCores
11) License Type
12) Hardware Family
13) Time Zone
14) Database Collation

## Deployment steps

From the root of the repository, run this command:

    Deploy.ps1 data-managed-instance resourcegroupname

    Where:
        resourcegroupname = The name of the resource group

### Connect

SQL Server Management Studio: Navigate to the new managed instance. On the Overview page, copy the value for the Host. Paste that value in to SSMS, provide the admin login and password.

Application: Navigate to the new managed instance. On the Connection strings page, select the appropriate tab at the top. Copy the value for the connection string. Place that in your application's configuration file, replacing the User ID and Pasword.

#### Management

How to manage the solution

vCores and Data max size can be adjusted from the "Pricing Tier" page. Slide to desired values. Click Apply.

Backup Retention can be configured by selecting the individual databases and then "Configure backup retention". You can adjust the slider between 7 and 35 days.

Restore databases by selecting the database then selecting restore, then a restore point

Manual backups can be peformed from a tool such as SSMS but they must be COPY_ONLY backups and written to a URL.

## Deprovision

Make note of the Virtual Network/subnet and Virtual Cluster from the Managed Instance Overview page

Manually delete the managed instanace

Find the Virtual Cluster, verify there are no Managed Instances associated

Delete the Virtual Cluster. Refreshing the Resource Group will show the Virtual cluster. It does not delete right away. You wil have to wait several hours.

Once the Virtual Cluster has been deleted, delete the subnet and Network Security Group.

Delete the Resource Group.

## Notes

Solution notes
