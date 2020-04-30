#Define the subscription's ID
$MSPSub = "dd2c542a-aeaf-4cef-9ccd-e89ae5864c3f"

#Log into CSP tenant using interactive credentials
Connect-AzureRmAccount -Subscription $MSPSub

#Define deployment parameters
$RGName = "msp-rsarg-blob"

#Remove the resource group
Remove-AzureRMResourceGroup -Name $RGName -Force
