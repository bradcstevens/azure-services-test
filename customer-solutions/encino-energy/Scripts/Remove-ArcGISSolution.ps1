# Variables
$RG="MSP-MJS-EncinoArcGIS01-EastUS"
$TenantID="de9231de-45f4-4325-ae07-8ae72052517e"
$SubscriptionID="dd2c542a-aeaf-4cef-9ccd-e89ae5864c3f"


Connect-AzAccount

#Establish the corrent tenant and subscription context the solution resides within.
Set-AzContext -Tenant $TenantID -Subscription $SubscriptionID

# Remove the Resource Group containing the solution you want to delete.
Remove-AzResourceGroup -Name $RG
