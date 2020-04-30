#Define deployment parameters
$SubID = Read-Host "Enter the customer's Subscription ID"
$RGName = Read-Host "Enter a unique name for your Azure Redis Cache Resource Group"
$Location = Read-Host "Enter the desired Azure region; location list at https://azure.microsoft.com/en-us/global-infrastructure/locations/"
#$redisCacheName = Read-Host "Name for the Azure Redis Cache Instance"
$OwnerTag = Read-Host "Enter the name of the resource group owner"
$TemplateFile = "C:\azure-redis-cache\provisioning\template.json"

#Log into CSP tenant using interactive credentials
Connect-AzAccount -Subscription $SubID

#Create the resource group
New-AzResourceGroup -Name $RGName -Location $Location -Tag @{Owner=$OwnerTag}

#Push the deployment
New-AzResourceGroupDeployment -ResourceGroupName $RGName -TemplateFile $TemplateFile 

