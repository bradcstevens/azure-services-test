# Variables
$Location="EastUS"
$RG="MSP-MJS-ADDS01-EastUS"
$TenantID="de9231de-45f4-4325-ae07-8ae72052517e"
$SubscriptionID="dd2c542a-aeaf-4cef-9ccd-e89ae5864c3f"
$Owner="Matt Sherwood" #Used for the Owner tag that will be configured on all deployed resources.
$Timestamp=(Get-Date -format "MM-dd-yyyy_HH-mm-ss")
$DeploymentName = "ADDSInitialDeployment_" + $Timestamp


#Connect to Azure. This will check if an existing session is functional. If not, it will prompt for credentials.
$i = 0
do {
    $i ++
    $Subscriptions = Get-AzSubscription
    if ($null -eq $Subscriptions) {
        Connect-AzAccount
    }
} until ($Subscriptions -or ($i -lt 5))

if ($null -eq $Subscriptions) {
    Write-Host "PowerShell was unable to establish a connection to Azure. Please verify that Azure PowerShell is running correctly. We will now close the script." -foregroundcolor Red
    Pause
    exit
}
$Subscriptions = $null


#Establish the correct tenant and subscription to which we will deploy the solution.
Set-AzContext -Tenant $TenantID -Subscription $SubscriptionID

# Check if Resource Group already exists. If it exists, then don't create a new one. If not, then create a new RG.
$RgCheck = Get-AzResourceGroup -Name $RG -ErrorAction SilentlyContinue
if ($null -eq $RgCheck) {
    Write-Host "Creating resource group." -ForegroundColor Cyan
    New-AzResourceGroup -Name $RG -Location $Location -Tag @{Owner=$Owner}
} else {
    Write-Host "Resource group already exists" -ForegroundColor yellow
}

#Deploy Solution
New-AzResourceGroupDeployment `
    -ResourceGroupName $RG `
    -TemplateFile ".\ADDSSolution.template.json" `
    -TemplateParameterFile ".\ADDSSolution.parameters.json" `
    -Name $DeploymentName
