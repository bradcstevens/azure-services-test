# Create a Resource Group for Azure Function
New-AzResourceGroup -Name "MSP-Function" -Location "northcentralus"
New-AzResourceGroupDeployment -ResourceGroupName "MSP-Function" -TemplateFile "azuredeploy.json" -TemplateParameterFile "azuredeploy.parameters.json"