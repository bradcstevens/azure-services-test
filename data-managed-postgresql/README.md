# **Azure Database for PostgreSQL**

This template deploys an Azure Database for PostgreSQL with preconfigured values.

## **Overview**

Azure Database for PostgreSQL is a relational database service based on the open-source Postgres database engine. It's a fully managed database-as-a-service offering that can handle mission-critical workloads with predictable performance, security, high availability, and dynamic scalability. It's available in two deployment options, as a single server and as a Hyperscale (Citus) cluster. The Hyperscale (Citus) option horizontally scales queries across multiple machines using sharding, and serves applications that require greater scale and performance.

## **Resources deployed as part of the solution:**

### Azure Resource Group:

Azure Resource Group is a logical collection of VMs, services, web apps that can be grouped together. Typically, users will group related resources for an application, divided into groups for production and non-production like prod and non-prod environments. 
A Resource Group called ‘msp-data-platform-azure-postgres-megha-gupta’ is created as part of this deployment.

### Azure Database for PostgreSQL

Azure Database for PostgreSQL is a relational database service based on the open-source Postgres database engine. It's a fully managed database-as-a-service offering that can handle mission-critical workloads with predictable performance, security, high availability, and dynamic scalability.
A PostgreSQL resource called ‘msp-postgres-mgupta’ is deployed. 

## **What files are included in this solution:**

* Azure Resource Manager Template to provision a PostgreSQL database-as-a-service
* Parameter file that defines the unique servername, admin user and admin password
* Powershell script to deploy the template in a named resource group
* Readme file
* Powershell script to deprovision/delete the whole Resource Group

## **Prerequistes for the Deployment**

* Azure subscription
* Azure Powershell version 1.0.0 or later

## **Deployment steps**

1.	Launch Powershell and sign in with your Azure credentials.
2.	At the prompt type "./Postgresdeployment.ps1"

## **Usage**

### **Connect**
Since this is Azure Database for PostgreSQL which is a database-as-a-service, there is no VM to connect to. You can connect to your Azure database for postgresql via a tool like pgadmin.

### **Management**
You can manage or edit the parameter.json file using visual studio code to update values accordingly.

## **Notes**
Solution notes #Azure Managed PostgreSQL will be provisioned accordingly using Azure resource manager/Portal/CI into the Azure tenant.


