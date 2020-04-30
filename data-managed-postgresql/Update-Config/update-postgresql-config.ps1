### To Update an Azure Database for PostgreSQL

# Set value of **log_retention_days**
az postgres server configuration set --resource-group postgres-staging-data-platform-environment --server-name postgres-db-stg-01 --name log_retention_days --value 7

# Update Admin password
az postgres server Update -g postgres-staging-data-platform-environment -n postgres-db-stg-01 --admin-password 1PG@Admin

# Update SSL
az postgres server update --name postgres-db-stg-01 --resource-group postgres-staging-data-platform-environment --ssl-enforcement Enabled

# Restart a Server
az postgres server restart -g postgres-staging-data-platform-environment -n postgres-db-stg-01

# Update Firewall rules
az postgres server firewall-rule update -g postgres-staging-data-platform-environment -s postgres-db-stg-01 -n msp-postgres-mguptafirewall --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0
