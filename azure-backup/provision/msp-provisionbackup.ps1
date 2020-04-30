#Define deployment parameters
$SubID = Read-Host "Enter the customer's Subscription ID"
$RGName = Read-Host "Enter a unique name for your Azure Recovery Services Vault Resource Group"
$Location = Read-Host "Enter the desired Azure region; location list at https://azure.microsoft.com/en-us/global-infrastructure/locations/"
$RSVName = Read-Host "Enter a name for the Recovery Services Vault"
$StorageAccountName = Read-Host "Enter a name for the Storage Account backing the RSV"
$OwnerTag = Read-Host "Enter the name of the resource group owner"
$TemplateFile = "C:\Temp\MSP\azure-backup\azuredeploy.json"

#Log into CSP tenant using interactive credentials
Connect-AzAccount -Subscription $SubID

#Create the resource group
New-AzResourceGroup -Name $RGName -Location $Location -Tag @{Owner=$OwnerTag}

#Define the template parameters
$TemplateParams = @{
    RSVName = [string]$RSVName
    StorageAccountName = [string]$StorageAccountName
    ResourceLocation = [string]$Location
    ResourceOwner = [string]$OwnerTag
}

#Push the deployment
New-AzResourceGroupDeployment -ResourceGroupName $RGName -TemplateFile $TemplateFile -TemplateParameterObject $TemplateParams
