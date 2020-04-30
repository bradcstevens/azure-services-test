New-AzResourceGroup -Name "ExpressRouteDeploy" -Location "North Central US"
New-AzResourceGroupDeployment -ResourceGroupName "ExpressRouteDeploy" -TemplateFile "azuredeploy.json" -TemplateParameterFile "azuredeploy.parameters.json"





