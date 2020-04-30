param (
[string] $service,
[string] $rgName
)
if (!$service -or !$rgName) {

    if (!$service) { write-host "Missing service name" }
    if (!$rgName) { write-host "Missing resource group name" }
    
    write-host "`nUsage: ./remove.ps1 <ServiceName> <resourcegroupname>`n"
    write-host "Example:`n`n./remove.ps1 msp-sample-service msp-sample-rg`n"
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
Remove-AzureRmPowerBIEmbeddedCapacity -Name $service -ResourceGroupName $rgName -Force
