#After the Cosmos DB has been provisioned and configured, you can update the existing Azure Cosmos account/Databases/Containers: 
#including adding or removing a region, enabling multiple write regions, enabling automatic failover, changing the throughput of a 
#database, and also changing the throughput of a containers just to name a few
# Note: if the database or container does not have throughput set the operation will return a "Not Found" error.  container/database are both case sensitive
$resourceGroupName='msp-data-platform-azure-cosmos-teff-woodside'
$accountName='teffwoodside-cosmosaccount' 
$databaseName='teff-woodside-database1'
$containerName='Container1'
$newRU=500

az cosmosdb sql container throughput update -a $accountName -g $resourceGroupName -d $databaseName -n $containerName --throughput $newRU


