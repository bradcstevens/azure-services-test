New-AzResourceGroup -Name "N-COMPUTE-VMSSRG" -Location "Central US" 

New-AzResourceGroupDeployment -ResourceGroupName "N-COMPUTE-VMSSRG" -TemplateUri "D:\Houston\Scripts\CDW Azure Services\Azure Virtual Machine - Scale Sets/template.json"