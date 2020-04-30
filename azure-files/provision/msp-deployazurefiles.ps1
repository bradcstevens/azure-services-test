#Define the subscription's ID
$MSPSub = "dd2c542a-aeaf-4cef-9ccd-e89ae5864c3f"

#Log into CSP tenant using interactive credentials
Connect-AzureRmAccount -Subscription $MSPSub

#Define deployment parameters
$RGName = "msp-rsarg-files"
$TemplateFile = "C:\Temp\MSP\azure-files\azuredeploy.json"
$ParamFile = "C:\Temp\MSP\azure-files\azuredeploy.parameters.json"

#Create the resource group
New-AzureRMResourceGroup -Name $RGName -Location "North Central US" -Tag @{Empty=$null; Owner="Ross Sargent"}

#Push the deployment
New-AzureRMResourceGroupDeployment -ResourceGroupName $RGName -TemplateFile $TemplateFile -TemplateParameterFile $ParamFile
