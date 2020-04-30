# Azure Redis Cache

This template deploys an **Azure Redis Cache** with preconfigured values.

## Overview and deployed resources 

Azure Redis Cache is a secure data cache and messaging broker that provides high throughput and low-latency access to data for applications. Azure Redis Cache is a secure data cache and messaging broker that provides high throughput and low-latency access to data for applications.

## The following resources are deployed as part of the solution: 

### Azure Resource Group and Azure Redis Cache

+ **Azure Resource Group**: 

The service used to provision resources in your Azure subscription. It was first announced at Build 2014 when the new Azure portal ( portal.azure.com ) was announced and provides a new set of API's that are used to provision resources 

Description Azure Redis Cache: is based on this popular database, providing a powerful and secure way to cache your application's data in the Azure cloud

+ **Azure Redis Cache**: 

Based on the popular software Redis. It is typically used as a cache to improve the performance and scalability of systems that rely heavily on backend data-stores. ... Azure Cache for Redis is managed by Microsoft, hosted within Azure, and accessible to any application within or outside of Azure

## Prerequistes for the Deployment 

Azure subscription

Azure Powershell version 1.0.0 or later

## Deployment steps

1. Launch Powershell and sign in with your Azure credentials.

2. At the prompt type "./redisCacheDeploy.ps1"

## Usage 

## Connect 
Cache clients can connect to An Azure Cache for Redis instance. They will need the hostname, ports, and a key for the cache. Some clients might refer to these items by slightly different names. You can get the host name, ports, and keys by using the powershell commands below:

To get hostname/port: Get-AzRedisCache -Name contoso-twoodside-6 
To retrieve access keys: Get-AzRedisCacheKey -Name contoso-twoodside-6 -ResourceGroupName msp-data-platform-azure-redis-cache-teffany-wooodside

## Management 

You can manage Azure Redis Cache using  Powershell commands

+ **To get information about an Azure Cache for Redis:** 

Get-AzRedisCache -ResourceGroupName msp-data-platform-azure-redis-cache-teffany-wooodside

+ **To update an Azure Cache for Redis:**

 Update max memory policy setting: Set-AzRedisCache -ResourceGroupName msp-data-platform-azure-redis-cache-teffany-wooodside -Name contoso-twoodside-6 -RedisConfiguration @{"maxmemory-policy" = "allkeys-random"}

+ **To scale an Azure Cache for Redis:** 

Set-AzRedisCache -ResourceGroupName msp-data-platform-azure-redis-cache-teffany-wooodside -Name contoso-twoodside-6 -Size 2.5GB

+ **To update an Azure Cache for Redis:** 

The Set-AzRedisCache cmdlet can be used to update properties such as Size, Sku, EnableNonSslPort, and the RedisConfiguration values. 
Set-AzRedisCache -ResourceGroupName msp-data-platform-azure-redis-cache-teffany-wooodside -Name contoso-twoodside-6 -RedisConfiguration @{"maxmemory-policy" = "allkeys-random"}

## Notes 
Solution notes #Azure Redis Cache will be provisioned accordingly using Azure resource manager/Portal/CI into the Azure tenant.

Tags: Tag1, Tag2, Tag3