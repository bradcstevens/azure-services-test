#Define deployment parameters
$SubID = Read-Host "Enter the customer's Subscription ID"
$RGName = Read-Host "Enter a unique name for your Azure Archive Resource Group"
$Location = Read-Host "Enter the desired Azure region; location list at https://azure.microsoft.com/en-us/global-infrastructure/locations/"
$HotArchiveName = Read-Host "Name for the Hot Tier Storage Account"
$CoolArchiveName = Read-Host "Name for the Cool Tier Storage Account"
$OwnerTag = Read-Host "Enter the name of the resource group owner"
$TemplateFile = "C:\Temp\MSP\azure-archive\azuredeploy.json"

#Log into CSP tenant using interactive credentials
Connect-AzAccount -Subscription $SubID

#Create the resource group
New-AzResourceGroup -Name $RGName -Location $Location -Tag @{Owner=$OwnerTag}

#Define the template parameters
$TemplateParams = @{
    HotArchiveAccountName = [string]$HotArchiveName
    CoolArchiveAccountName = [string]$CoolArchiveName
}

#Push the deployment
New-AzResourceGroupDeployment -ResourceGroupName $RGName -TemplateFile $TemplateFile -TemplateParameterObject $TemplateParams
