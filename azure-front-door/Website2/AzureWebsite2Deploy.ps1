# Create a Resource Group for Azure Front Door Website 2
New-AzResourceGroup -Name "MSP-Website2" -Location "eastus"
New-AzResourceGroupDeployment -ResourceGroupName "MSP-Website2" -TemplateFile "azuredeploy.json" -TemplateParameterFile "azuredeploy.parameters.json"