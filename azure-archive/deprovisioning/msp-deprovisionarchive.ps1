#Define deployment parameters
$SubID = Read-Host "Enter the customer's Subscription ID"
$RGName = Read-Host "Enter the name of the Azure Archive Resource Group"

#Log into CSP tenant using interactive credentials
Login-AzAccount -Subscription $SubID

#Delete the resource group
Remove-AzResourceGroup -Name $RGName -Force
