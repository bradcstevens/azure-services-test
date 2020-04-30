#Check for the presence of the Az.Storage module; install/import if not found, import if found
$StorageModule = (Get-Module -Name Az.Storage).Name

if ($StorageModule -like "Az.Storage") {
    Import-Module -Name Az.Storage
    }
else {
    Install-Module -Name Az.Storage -AllowClobber -Force
    Import-Module -Name Az.Storage
    }

#Define the subscription's ID
$MSPSub = "dd2c542a-aeaf-4cef-9ccd-e89ae5864c3f"

#Log into CSP tenant using interactive credentials
Login-AzAccount -Subscription $MSPSub

#Define deployment parameters
$RGName = "msp-rsarg-blob"
$SAName = "msprsargblobstorage"

#Set context for Hot Tier storage account
$SAKey = (Get-AzStorageAccountKey -ResourceGroupName $RGName -Name $SAName | Where-Object {$_.KeyName -eq "key1"}).Value
$Context = New-AzStorageContext -StorageAccountName $SAName -StorageAccountKey $SAKey

#Upgrade the Storage Account from GenPurpose v1 to v2
Set-AzStorageAccount -ResourceGroupName $RGName -Name $SAName -UpgradeToStorageV2

#Change redundancy settings on the Storage Account
Set-AzStorageAccount -ResourceGroupName $RGName -Name $SAName -SkuName Standard_GRS

#Set Access Tier to Cool after the v2 upgrade
Set-AzStorageAccount -ResourceGroupName $RGName -Name $SAName -AccessTier Cool

#Configure Lifecycle Management Policies to move data between storage tiers at configured data ages
$CoolToArchiveAction = Add-AzStorageAccountManagementPolicyAction -BaseBlobAction TierToArchive -DaysAfterModificationGreaterThan 180
$Filter = New-AzStorageAccountManagementPolicyFilter -PrefixMatch (Get-AzStorageContainer -Context $Context).Name
$CtARule = New-AzStorageAccountManagementPolicyRule -Name "Cool to Archive" -Action $CoolToArchiveAction -Filter $Filter
$CtAPolicy = Set-AzStorageAccountManagementPolicy -ResourceGroupName $RGName -StorageAccountName $SAName -Rule $CtARule
