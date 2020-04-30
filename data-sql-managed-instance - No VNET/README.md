# Managed Instance

<
This template deploys a Managed Instance (MI). The MI is 1 or more databases contained in an instance of SQL Server. This solution is PaaS and therefore the file sytem and the operating system are obfuscated from the user. Patching of the host as well as backups are maintained automatically by Azure. MI maintains a high level of feature parity with a traditional installation of SQL server.

## Overview and deployed resources

The following resources are deployed as part of the solution

* Managed Instance
* Route Tables
* Network Security Group

## Prerequisites

Before an MI can be created, the following must already exist:

1) Resource Group

## Requirements

The following items must be provided in the form of parameters placed in the parameters file:

 1) Managed Instance Name
 2) Administrator Login
 3) Administrator Password
 4) Location
 5) SKU Name
 6) SKU Edition
 7) Storage Size In GB
 8) vCores
 9) License Type
10) Hardware Family
11) Time Zone
12) Database Collation

## Deployment steps

Follow the instructions for command line deployment using the scripts in the root of this repo **(under construction)**.  The instructions should succinctly spell out how to execute this script.

## Usage

### Connect

How to connect to the solution

#### Management

How to manage the solution

## Notes

Solution notes
