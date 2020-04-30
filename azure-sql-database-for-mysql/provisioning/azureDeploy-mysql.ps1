az group delete --name msp-data-platform-azure-mysql-teff-woodside -y

# Provision a  Azure SQL Database for MySQL General Purpose, 2vCore in the same location as the Resource Group
# You select: ServerName, Admin Login, Admin password, MySQL version, BackupRention Days, and Storage Size

# Create Resource Group 
az group create --name msp-data-platform-azure-mysql-teff-woodside --location centralus --tags 'Owner=TeffWoodside'

# Assign a policy to the RG
az policy assignment create --name 'audit-mysql-geo-redundant-backups' --display-name 'Audit MySQL databases where geo-redundant backups are not enabled' --scope '/subscriptions/dd2c542a-aeaf-4cef-9ccd-e89ae5864c3f/resourceGroups/msp-data-platform-azure-mysql-teff-woodside' --policy '82339799-d096-41ae-8538-b108becf0970'

# Deploy the Azure SQL Database for MySQL
$serverName='use this as the servername : "teff-mysql-demo-server"'
$templateFile="C:\azure-redis-cache\azure-quickstart-templates\101-managed-mysql-with-vnet\provisioning\azuredeploy-new.json"
$serverName
az group deployment create --name teff-wooodside-provision-azure-mysql-db --resource-group msp-data-platform-azure-mysql-teff-woodside --template-file $templateFile 
