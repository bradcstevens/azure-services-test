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
$CoolSAName = Read-Host "Name for the Cool Tier Storage Account"
$TestDoc = "C:\Temp\MSP\azure-archive\TestDocument.txt"
$TestDir = "C:\Temp\MSP\azure-archive\TestDirectory"

#Log into CSP tenant using interactive credentials
Login-AzAccount -Subscription $SubID

#Set context for Hot Tier storage account
$HotSAKey = (Get-AzStorageAccountKey -ResourceGroupName $RGName -Name $HotSAName | Where-Object {$_.KeyName -eq "key1"}).Value
$HotContext = New-AzStorageContext -StorageAccountName $HotSAName -StorageAccountKey $HotSAKey
$HotContainer = Get-AzStorageContainer -Context $HotContext

#Set context for Cool Tier storage account
$CoolSAKey = (Get-AzStorageAccountKey -ResourceGroupName $RGName -Name $CoolSAName | Where-Object {$_.KeyName -eq "key1"}).Value
$CoolContext = New-AzStorageContext -StorageAccountName $CoolSAName -StorageAccountKey $CoolSAKey
$CoolContainer = Get-AzStorageContainer -Context $CoolContext

#Upload a single file to the Hot Tier archive container
Set-AzStorageBlobContent -File $TestDoc -Context $HotContext -Container $HotContainer.Name -StandardBlobTier Archive

#Upload an entire directory's worth of files to the Cool Tier archive container
Get-ChildItem $TestDir -File -Recurse | Set-AzStorageBlobContent -Context $CoolContext -Container $CoolContainer.Name -StandardBlobTier Archive

#Configure Lifecycle Management Policies to move data between storage tiers at configured data ages
$CoolToArchiveAction = Add-AzStorageAccountManagementPolicyAction -BaseBlobAction TierToArchive -DaysAfterModificationGreaterThan 180
$Filter = New-AzStorageAccountManagementPolicyFilter -PrefixMatch $CoolContainer
$CtARule = New-AzStorageAccountManagementPolicyRule -Name "Cool to Archive" -Action $CoolToArchiveAction -Filter $Filter
Set-AzStorageAccountManagementPolicy -ResourceGroupName $RGName -StorageAccountName $CoolSAName -Rule $CtARule
