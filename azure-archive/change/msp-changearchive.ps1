#Check for the presence of the Az.Storage module; install/import if not found, import if found
$StorageModule = (Get-Module -Name Az.Storage).Name

if ($StorageModule -like "Az.Storage") {
    Import-Module -Name Az.Storage
	Update-Module -Name Az.Storage -Force
    }
else {
    Install-Module -Name Az.Storage -AllowClobber -Force
    Import-Module -Name Az.Storage
    }

#Define deployment parameters
$SubID = Read-Host "Enter the customer's Subscription ID"
$RGName = Read-Host "Enter the name of the Azure Archive Resource Group"
$HotSAName = Read-Host "Name for the Hot Tier Storage Account"

#Log into CSP tenant using interactive credentials
Login-AzAccount -Subscription $SubID

#Set the storage context for a blob
$SAKey = (Get-AzStorageAccountKey -ResourceGroupName $RGName -Name $HotSAName | Where-Object {$_.KeyName -eq "key1"}).Value
$HotContext = New-AzStorageContext -StorageAccountName $HotSAName -StorageAccountKey $SAKey
$HotContainer = Get-AzStorageContainer -Context $HotContext

#Get the contents of a blob
$BlobContent = Get-AzStorageBlob -Context $HotContext -Container $HotContainer.Name

#Convert the contents of the blob to the Archive storage tier
$BlobContent.icloudblob.setstandardblobtier("Archive")

#Convert the Hot storage account to the Cool tier
Set-AzStorageAccount -ResourceGroupName $RGName -Name $HotSAName -AccessTier Cool
