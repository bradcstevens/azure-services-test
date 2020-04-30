New-AzResourceGroup -Name "MSP-NSG-Charles-Omi" -Location "Central US"

New-AzResourceGroupDeployment -ResourceGroupName "MSP-NSG-Charles-Omi" -TemplateFile "C:\Users\charomi\Downloads\ARMScripts\NSG+VM\NSG+VM\template.json" -TemplateParameterFile "C:\Users\charomi\Downloads\ARMScripts\NSG+VM\NSG+VM\parameters.json"






