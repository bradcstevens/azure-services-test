# Configure Firewall Rules: 
az mysql server firewall-rule create --resource-group msp-data-platform-azure-mysql-teff-woodside --server teff-mysql-demo-server --name AllowMyIP --start-ip-address 45.26.190.188 --end-ip-address 45.26.190.188

# Configure/Modify a server configuration parameter value: To update the slow_query_log server configuration parameter:
az mysql server configuration set --name slow_query_log --resource-group msp-data-platform-azure-mysql-teff-woodside --server teff-mysql-demo-server --value ON

# Get connection information: 
az mysql server show --resource-group msp-data-platform-azure-mysql-teff-woodside --name teff-mysql-demo-server

# Update SSL settings: 
az mysql server update --resource-group msp-data-platform-azure-mysql-teff-woodside --name teff-mysql-demo-server --ssl-enforcement Disabled

# Update a server's sku (scale vCores up/down):
az mysql server update -g msp-data-platform-azure-mysql-teff-woodside -n teff-mysql-demo-server --sku-name MO_Gen5_2