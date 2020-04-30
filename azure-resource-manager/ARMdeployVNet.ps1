New-AzResourceGroup -Name "MSP-ARM-Charles-Omi" -Location "Central US"

New-AzResourceGroupDeployment -ResourceGroupName "MSP-ARM-Charles-Omi" -TemplateFile "C:\Users\charomi\Downloads\Azure Services\Azure Recource Manager\ExportedTemplate-MSP-ARM-Charles-Omi\template.json" -TemplateParameterFile "C:\Users\charomi\Downloads\Azure Services\Azure Recource Manager\ExportedTemplate-MSP-ARM-Charles-Omi\parameters.json"






