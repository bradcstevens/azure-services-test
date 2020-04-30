# To update an Azure Cache for Redis:

#Update max memory policy setting: 
Set-AzRedisCache -ResourceGroupName msp-data-platform-azure-redis-cache-teff-woodside -Name twoodside-delete-me-redis-cache-1 -RedisConfiguration @{"maxmemory-policy" = "allkeys-random"}

# To scale an Azure Cache for Redis: 

Set-AzRedisCache -ResourceGroupName msp-data-platform-azure-redis-cache-teff-woodside -Name twoodside-delete-me-redis-cache-1 -Size 1GB

# To update an Azure Cache for Redis: 
#The Set-AzRedisCache cmdlet can be used to update properties such as Size, Sku, EnableNonSslPort, and the RedisConfiguration values. 

Set-AzRedisCache -ResourceGroupName msp-data-platform-azure-redis-cache-teff-woodside -Name twoodside-delete-me-redis-cache-1 -RedisConfiguration @{"maxmemory-policy" = "allkeys-random"}