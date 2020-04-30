New-AzResourceGroup -Name "MSP-ARM-Charles-Omi" -Location "Central US"

New-AzResourceGroupDeployment -ResourceGroupName "MSP-ARM-Charles-Omi" -TemplateFile "D:\Houston\Scripts\CDW Azure Services\Create-a-Windows-VM\template.json" -TemplateParameterFile "D:\Houston\Scripts\CDW Azure Services\Create-a-Windows-VM\parameters.json"






