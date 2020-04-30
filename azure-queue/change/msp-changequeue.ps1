#Define the ID for the test subscription
$MSPSub = "dd2c542a-aeaf-4cef-9ccd-e89ae5864c3f"

#Log into CSP tenant using interactive credentials
Connect-AzureRmAccount -Subscription $MSPSub

#Define deployment parameters
$RGName = "msp-rsarg-queue"
$SAName = "msprsargqueuestorage"

#Upgrade the Storage Account from GenPurpose v1 to v2
Set-AzureRMStorageAccount -ResourceGroupName $RGName -Name $SAName -UpgradeToStorageV2

#Change redundancy settings on the Storage Account
Set-AzureRMStorageAccount -ResourceGroupName $RGName -Name $SAName -SkuName Standard_GRS
