#Create an Azure Cosmos account, database, and container, example: central us, east us. This script takes about 20 minutes to run.
#$resourceGroupName='msp-data-platform-azure-cosmos-teff-woodside'
#$accountName='teffwoodside-cosmosaccount' 
#$databaseName='teff-woodside-database1'
#$primaryregion='central us'
#$secondaryregion='east us'

# Create Resource Group 
az group create --name msp-data-platform-azure-cosmos-teff-woodside --location centralus --tags 'Owner=TeffWoodside'

$templateFile="C:\azure-cosmos-db\provisioning\provision.json"
az group deployment create --name teff-wooodside-provision-azure-cosmos-db --resource-group msp-data-platform-azure-cosmos-teff-woodside --template-file $templateFile 
