New-AzResourceGroup -Name "N-COMPUTE-VMSSRG" -Location "Central US"
New-AzResourceGroupDeployment -ResourceGroupName "N-COMPUTE-VMSSRG" -TemplateFile "D:\Houston\Scripts\CDW Azure Services\Azure Managed Disk\template.json" -TemplateParameterFile "D:\Houston\Scripts\CDW Azure Services\Azure Managed Disk\parameters.json"





