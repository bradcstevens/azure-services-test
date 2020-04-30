# Variables
$Location="RegionName"
$RG="ResourceGroupName"
$TenantID="xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
$SubscriptionID="xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
$Owner="Owner Name" #Used for the Owner tag that will be configured on all deployed resources.
$Timestamp=(Get-Date -format "MM-dd-yyyy_HH-mm-ss")
$DeploymentName = "DataBoxStaging_" + $Timestamp


#Connect to Azure. This will check if an existing session is functional. If not, it will prompt for credentials.
$i = 0
do {
    $i ++
    $Subscriptions = Get-AzSubscription
    if ($Subscriptions -eq $null) {
        Connect-AzAccount
    }
} until ($Subscriptions -or ($i -lt 5))

if ($Subscriptions -eq $null) {
    Write-Host "PowerShell was unable to establish a connection to Azure. Please verify that Azure PowerShell is running correctly. The script will now close." -foregroundcolor Red
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
    -TemplateFile ".\DataBoxSolution.template.json" `
    -TemplateParameterFile ".\DataBoxSolution.parameters.json" `
    -Name $DeploymentName
