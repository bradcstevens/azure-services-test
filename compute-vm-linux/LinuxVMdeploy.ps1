New-AzResourceGroup -Name "MSP-NSG-Charles-Omi" -Location "Central US"

New-AzResourceGroupDeployment -ResourceGroupName "MSP-NSG-Charles-Omi" -TemplateFile "D:\Houston\Scripts\CDW Azure Services\Create-a-Linux-VM\template.json" -TemplateParameterFile "D:\Houston\Scripts\CDW Azure Services\Create-a-Linux-VM\parameters.json"






