#Define the subscription's ID
$MSPSub = "dd2c542a-aeaf-4cef-9ccd-e89ae5864c3f"

#Log into CSP tenant using interactive credentials
Connect-AzureRmAccount -Subscription $MSPSub

#Define deployment parameters
$RGName = "msp-rsarg-queue"
$TemplateFile = "C:\Temp\MSP\azure-queue\template.json"
$ParamFile = "C:\Temp\MSP\azure-queue\parameters.json"
$Queue = "msprsargqueue"

#Create the resource group
New-AzureRMResourceGroup -Name $RGName -Location "North Central US" -Tag @{Empty=$null; Owner="Ross Sargent"}

#Push the deployment
New-AzureRMResourceGroupDeployment -ResourceGroupName $RGName -TemplateFile $TemplateFile -TemplateParameterFile $ParamFile

#Get the Storage Account access key and set the storage context for the creation of the queue.
$SAKey = (Get-AzureRmStorageAccountKey -ResourceGroupName $RGName -Name $SAName | Where-Object {$_.KeyName -eq "key1"}).Value
$Context = New-AzureStorageContext -StorageAccountName $SAName -StorageAccountKey $SAKey

New-AzureStorageQueue -Name $Queue -Context $Context
