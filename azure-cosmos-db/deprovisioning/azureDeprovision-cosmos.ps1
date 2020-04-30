# The solution is deleted by using the following process:
# To delete the entire resource group which deletes the Azure Cosmos account and the related resources:
$resourceGroupName='msp-data-platform-azure-cosmos-teff-woodside'
az group delete --name $resourceGroupName -y
