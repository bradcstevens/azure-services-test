# Create a Resource Group for Azure Front Door Website 1
New-AzResourceGroup -Name "MSP-FrontDoor" -Location "northcentralus"
New-AzResourceGroupDeployment -ResourceGroupName "MSP-FrontDoor" -TemplateFile "azuredeploy.json" -TemplateParameterFile "azuredeploy.parameters.json"