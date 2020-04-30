New-AzResourceGroup -Name "N-COMPUTE-VMSSRG" -Location "Central US"
New-AzResourceGroupDeployment -ResourceGroupName "N-COMPUTE-VMSSRG" -TemplateFile "D:\Houston\Scripts\CDW Azure Services\Azure Batch - Inprogress\template.json" -TemplateParameterFile "D:\Houston\Scripts\CDW Azure Services\Azure Batch - Inprogress\parameters.json"





