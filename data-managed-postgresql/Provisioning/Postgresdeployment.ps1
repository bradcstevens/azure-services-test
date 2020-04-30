New-AzResourceGroup -Name "postgres-staging-data-platform-environment" -Location "Central US" -Tag @{Empty=$null; Owner="MeghaGupta"}

New-AzResourceGroupDeployment -ResourceGroupName "postgres-staging-data-platform-environment" -TemplateFile "C:\Megha\CDW\Azure\Managed-PostgreSQL\Generalized-scripts\azuredeploy-postgres.json" -TemplateParameterFile "C:\Megha\CDW\Azure\Managed-PostgreSQL\Generalized-scripts\parameters.json"
