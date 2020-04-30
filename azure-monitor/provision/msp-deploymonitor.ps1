#Define the ID for the test subscription
$MSPSub = "dd2c542a-aeaf-4cef-9ccd-e89ae5864c3f"

#Log into CSP tenant using interactive credentials
Connect-AzureRmAccount -Subscription $MSPSub

#Define deployment parameters
$RGName = "msp-rsarg-monitor"
$TemplateFile = "C:\Temp\MSP\azure-monitor\azuredeploy.json"
$ParamFile = "C:\Temp\MSP\azure-monitor\azuredeploy.parameters.json"

#Create the resource group
New-AzureRMResourceGroup -Name $RGName -Location "North Central US" -Tag @{Empty=$null; Owner="Ross Sargent"}

#Push the deployment
New-AzureRMResourceGroupDeployment -ResourceGroupName $RGName -TemplateFile $TemplateFile -TemplateParameterFile $ParamFile
