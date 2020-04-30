# Create a Resource Group for Logic App
New-AzResourceGroup -Name "MSP-LogicApp" -Location "northcentralus"
New-AzResourceGroupDeployment -ResourceGroupName "MSP-LogicApp" -TemplateFile "azuredeploy.json" -TemplateParameterFile "azuredeploy.parameters.json"