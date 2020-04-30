# Create a Resource Group for Azure Front Door Website 1
New-AzResourceGroup -Name "MSP-Website1" -Location "westus"
New-AzResourceGroupDeployment -ResourceGroupName "MSP-Website1" -TemplateFile "azuredeploy.json" -TemplateParameterFile "azuredeploy.parameters.json"