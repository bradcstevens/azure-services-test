
New-AzResourceGroup -Name "msp-data-platform-azure-redis-cache-teff-woodside" -Location "Central US" -Tag @{Empty=$null; Owner="TeffanyWoodside"}

New-AzResourceGroupDeployment -ResourceGroupName "msp-data-platform-azure-redis-cache-teff-woodside" -TemplateFile "C:\Users\teffsim\Desktop\cdwlabs-github\azure-services\Azure Redis Cache\provisioning\template.json" -TemplateParameterFile "C:\Users\teffsim\Desktop\cdwlabs-github\azure-services\Azure Redis Cache\provisioning\parameters.json" 
