# Azure Stream Analytics

This template deploys an **Azure Stream Analaytics** job. **Azure Stream Analytics** is a **real-time analytics and complex event-processing engine that is designed to analyze and process high volumes of fast streaming data from multiple sources simultaneously. Patterns and relationships can be identified in information extracted from a number of input sources including devices, sensors, clickstreams, social media feeds, and applications. These patterns can be used to trigger actions and initiate workflows such creating alerts, feeding information to a reporting tool, or storing transformed data for later use. Also, Stream Analytics is available on Azure IoT Edge runtime, and supports the same exact language or syntax as cloud.**

## Overview and deployed resources

TThis template will deploy a Stream Analytics job. A generic query will be added, but must be configured.
+ SELECT\r\n    *\r\nINTO\r\n    [YourOutputAlias]\r\nFROM\r\n    [YourInputAlias]

The following resources are deployed as part of the solution

### Resource provider

+ **Resource type**: Microsoft.StreamAnalytics/StreamingJobs

## Prerequisites

Decscription of the prerequistes for the deployment

## Deployment steps

Modify the azuredeploy.parameters.json file to include the following for each customer: 
+ streamAnalyticsJobName - can contain alphanumeric characters and hypen and must be 3-63 characters long
+ numberOfStreamingUnits - accepted values are:  
        1,
        3,
        6,
        12,
        18,
        24,
        30,
        36,
        42,
        48

**Additional Parameters here**
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


## Removal steps

From a PowerShell window, execute the remove.ps1 script with the following parameters:

+ ServiceName    -  The name of the Azure service being removed
+ ResourceGroup  -  The name of the resource group for removal

```
.\remove.ps1  <ServiceName> <ResourceGroup>

```
_Example:_

  .\remove.ps1 msp-sample-adl msp-adl-rg

  Will remove the service *msp-sample-asa* from the *msp-asa-rg* resource group.

## Usage

### Connect

Inputs and Outputs will generally be manually configured by the customer. If not, these can be configured via the included json script. These will establish the input and output data streams, including any aggregations or transformations.

#### Management

This solution can be managed via Azure Portal, PowerShell, Visual Studio, or Visual Studio Code.


## Notes
https://docs.microsoft.com/en-us/azure/stream-analytics/stream-analytics-introduction

https://docs.microsoft.com/en-us/azure/stream-analytics/



`Tags: Azure Stream Analytics`