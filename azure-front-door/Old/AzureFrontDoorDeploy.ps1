## Specify Variables
# Resorce Group Locations
$WebAppRGLocation1="WestUS"
$WebAppRGLocation2="EastUS"
$FrontDoorRGLocation="NorthCentralUS"

# Resource Group Names
$WebAppRG1="MSP-FrontDoor1WebApp1-WestUS"
$WebAppRG2="MSP-FrontDoor1WebApp2-EastUS"
$FrontDoorRG="MSP-FrontDoor-NorthCentralUS"

## DO NOT MODIFY BELOW THIS LINE ##

# Create a Resource Group for WebApp
New-AzResourceGroup -Name $WebAppRG1 -Location $WebAppRGLocation1

# Create a Resource Group for WebApp
New-AzResourceGroup -Name $WebAppRG2 -Location $WebAppRGLocation2

# Create a Resource Group for WebApp
New-AzResourceGroup -Name $FrontDoorRG -Location $FrontDoorRGLocation

## Create Web App Names
# Assign Web App Names at Random
$App1Name="AppServiceTM1$Random"
$App2Name="AppServiceTM2$Random"

# Generate a random value
$Random=(New-Guid).ToString().Substring(0,8)

# Create an App service plan
New-AzAppservicePlan -Name "$App1Name-Plan" -ResourceGroupName $WebAppRG1 -Location $WebAppRGLocation1 -Tier Standard
New-AzAppservicePlan -Name "$App2Name-Plan" -ResourceGroupName $WebAppRG2 -Location $WebAppRGLocation2 -Tier Standard

# Create a Web App in the App Service Plan
$App1HostName=(New-AzWebApp -Name $App1Name -ResourceGroupName $WebAppRG1 -Location $WebAppRGLocation1 -AppServicePlan "$App1Name-Plan").DefaultHostName
$App2HostName=(New-AzWebApp -Name $App2Name -ResourceGroupName $WebAppRG2 -Location $WebAppRGLocation2 -AppServicePlan "$App2Name-Plan").DefaultHostName

Write-Host " "
WRite-Host " "
Write-Host "App1HostName is $App1HostName" -ForegroundColor Green
Write-Host "App2HostName is $App2HostName" -ForegroundColor Green

Write-Host " "
Write-Host "ACTION NEEDED: Please open parameters.json and do the following:" -ForegroundColor Yellow
Write-Host " - Replace backendAddress1 value to be $App1HostName" -ForegroundColor Yellow
Write-Host " - Replace backendAddress1 value to be $App2HostName" -ForegroundColor Yellow

Write-Host " "
Read-Host -Prompt "Once completed, press any key to continue or CTRL+C to quit" 

New-AzResourceGroupDeployment -ResourceGroup $FrontDoorRG -TemplateFile "azuredeploy.json" -TemplateParameterFile "azuredeploy.parameters.json"