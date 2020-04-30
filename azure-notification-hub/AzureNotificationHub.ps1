New-AzResourceGroup -Name "NotificationHub" -Location "North Central US"
New-AzResourceGroupDeployment -ResourceGroupName "NotificationHub" -TemplateFile "azuredeploy.json" -TemplateParameterFile "azuredeploy.parameters.json"





