# Apache Spark Cluster

This template deploys an **Apache Spark Cluster on Linux in Azure HD Insight** . **Apache Spark** is a **parallel processing framework that supports in-memory processing to boost the performance of big-data analytic applications**

## Overview and deployed resources

This is an overview of the solution
This template will create a Spark Cluster in Azure HDInsight, which is is the Microsoft implementation of Apache Spark in the cloud. There is a template file, and a parameters file, which allows specific customer settings to be applied.

The following resources are deployed as part of the solution

### Resource provider

Description Resource Provider

+ **Resource type**: Microsoft.HDInsight/clusters


+ **Resource type**: Microsoft.Storage/storageAccounts

## Prerequisites

Azure subscription and resource group is the only prerequisite

## Deployment steps

Modify the azuredeploy.parameters.json file to include the following for each customer: 

- location
- clusterName
- clusterLoginUserName
- clusterLoginPassword
- sshUserName
- sshPassword
- tags (such as owner)

From a PowerShell window, execute the deploy.ps1 script with the following parameters:

+ ServiceName    -  The name of the Azure service being deployed
+ ResourceGroup  -  The name of the resource group for deployment

```
.\deploy.ps1  <ServiceName> <ResourceGroup>
```

_Example:_

  .\deploy.ps1 msp-sample-vnet msp-sample

  Will deploy the template located at .\msp-sample-vnet\azuredeploy.json into the *msp-sample* resource group.

## Usage

### Connect

Connection can be made through the Azure portal for service configuration. Queries can be run, for example, via Jupyter by navigating to https://CLUSTERNAME.azurehdinsight.net/jupyter.


## Notes

Solution notes

`Tags: clusterVersion: 3.6, osType: Linux, tier: Standard, clusterkind: spark`