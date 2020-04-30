# Minimum requirements for use is AZ.Resources 1.7.1
#
# Install:  Install-Module -Name Az.Resources -RequiredVersion 1.7.1
#
# https://www.powershellgallery.com/packages/Az.Resources/1.7.1

param (
    [string]$service,
    [string]$rgName
)

if (!$service -or !$rgName) {

    if (!$service) { write-host "Missing service name" }
    if (!$rgName) { write-host "Missing resource group name" }
    
    write-host "`nUsage: ./deploy.ps1 <ServiceName> <ResourceGroup>`n"
    write-host "Example:`n`n./deploy.ps1 msp-sample-vnet msp-sample`n"
    exit
}

function confirm($mesg) {
    write-host $mesg
    
    write-host "`nAre you sure you want to perform this action?"
    write-host -foregroundcolor yellow -nonewline "[Y] Yes "
    write-host -foregroundcolor white -nonewline "[N] No [Q] Quit " 
    $key = read-host "(default is 'Y')"
    
    if ($key -eq "" -or $key.ToLower() -eq "y") {
        return $true;
    }
    
    if ($key.ToLower() -eq "q") {
        exit
    }
    
    return $false;
}

$curDir            = Split-Path -parent $MyInvocation.MyCommand.Definition

$templateBasename  = "azuredeploy.json"
$paramBasename     = "azuredeploy.parameters.json"

$templateFile = "$curDir\$service\$templateBasename"
$paramFile    = "$curDir\$service\$paramBasename"


write-host "Service:       $service"
write-host "ResourceGroup: $rgName`n"
write-host "Template:      $templateFile"
write-host "Params:        $paramFile`n"

$result = confirm("Deploy service confirmation")

if ($result  -eq $false) {
    exit
}

New-AzResourceGroupDeployment -ResourceGroupName $rgName -TemplateFile $templateFile -TemplateParameterFile $paramFile