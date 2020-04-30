function Get-AzCachedAccessToken() {
    $ErrorActionPreference = 'Stop'
  
    if(-not (Get-Module Az.Accounts)) {
        Import-Module Az.Accounts
    }
    $azProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
    if(-not $azProfile.Accounts.Count) {
        Write-Error "Ensure you have logged in before calling this function."    
    }
  
    $currentAzureContext = Get-AzContext
    $profileClient = New-Object Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient($azProfile)
    Write-Debug ("Getting access token for tenant" + $currentAzureContext.Tenant.TenantId)
    $token = $profileClient.AcquireAccessToken($currentAzureContext.Tenant.TenantId)
    $token.AccessToken
}

function Get-AzBearerToken() {
    $ErrorActionPreference = 'Stop'
    ('Bearer {0}' -f (Get-AzCachedAccessToken))
}

# Provide your source subscription id
$subscriptionid = "04e718bb-ba92-45f9-a98f-fc6f58b30870"
# Provide your target subscription id (could be the same as source)
$targetsub = "b7b69b24-0412-4f5d-9472-f8f67e6d93af"

Select-AzSubscription $subscriptionid

Get-AzResourceGroup | select ResourceGroupName, Location | Export-Csv sourceSubResourceGroups.csv -NoTypeInformation

$resourceGroups = Import-Csv sourceSubResourceGroups.csv

Get-AzResourceProvider | Where-Object { $_.RegistrationState -eq "Registered" -and $_.ProviderNamespace -ne "Microsoft.ClassicSubscription" -and $_.ProviderNamespace -ne "Microsoft.Commerce" } | Select-Object ProviderNamespace | Export-Csv sourceRegisteredProviderNamespaces.csv -NoTypeInformation


Select-AzSubscription $targetsub

$resourceProviders = Import-Csv sourceRegisteredProviderNamespaces.csv

foreach ($resourceProvider in $resourceProviders) {
    $providerNamespace = $resourceProvider.ProviderNamespace
    Register-AzResourceProvider -ProviderNamespace $providerNamespace
}

do {
        $AzResourceProvider = Get-AzResourceProvider
}
until ($AzResourceProvider.RegistrationState -ne "Registering")

foreach ($resourceGroup in $resourceGroups) {
    New-AzResourceGroup -Name $resourceGroup.ResourceGroupName -Location $resourceGroup.Location
}

Select-AzSubscription $subscriptionid

foreach ($resourceGroup in $resourceGroups) {

    $resourceids = get-azresource -resourcegroupname $resourceGroup.ResourceGroupName

    $resourceids = $resourceids | Where-Object { $_.ResourceType -notlike "*/configurations" -and $_.ResourceType -notlike "*/runbooks" -and $_.ResourceType -notlike "*/extensions*" -and $_.ResourceType -notlike "*/applicationgateways*" -and $_.ResourceType -notlike "*/publicipaddresses*" -and $_.ResourceType -notlike "*/vaults*" -and $_.ResourceType -notlike "*/connections*" -and $_.ResourceType -notlike "*/localnetworkgateways*" -and $_.ResourceType -notlike "*/virtualnetworkgateways*" }
    
    if ($resourceids.count -gt 1) {
        $resourceids = $resourceids.resourceid | ConvertTo-JSON

        Write-host "Resource Ids are: $resourceids"

        $BearerToken = ('Bearer {0}' -f (Get-AzCachedAccessToken))

        $RequestHeader = @{
            "Content-Type"  = "application/json";
            "Authorization" = "$BearerToken"
        }

        $RequestHeader

        $sourcergname = $resourceGroup.ResourceGroupName
        write-host "Source Resource Group is: $sourcergname"

        $targetrgname = $resourceGroup.ResourceGroupName
        write-host "Target Resource Group is: $targetrgname"

$Body = @"
{
 "resources": $resourceids,
 "targetResourceGroup": "/subscriptions/$targetsub/resourceGroups/$targetrgname"
}
"@
        $Body

        $URI = "https://management.azure.com/subscriptions/$subscriptionid/resourceGroups/$sourcergname/validateMoveResources?api-version=2019-05-10"

        $URI

        $response = Invoke-WebRequest -Uri $URI -Method POST -body $body -header $RequestHeader

        Sleep 120

        $a = $response.rawcontent

        $a

        $checkURI = $a.Substring($a.IndexOf('https:'))

        Write-Host `n"checkURI String Value:"
        Write-Host "$checkURI" -ForegroundColor Yellow

        try {
            $CheckResponse = Invoke-WebRequest -Uri $checkURI -Method Get -header $RequestHeader
        }
        catch {
            $fileName = "validation-error-" + $sourcergname + ".json"
            $result = $_.Exception.Response.GetResponseStream()
            $reader = New-Object System.IO.StreamReader($result)
            $reader.BaseStream.Position = 0
            $reader.DiscardBufferedData()
            $responseBody = $reader.ReadToEnd();
            $responseBody | convertfrom-json | convertto-json -depth 100 | out-file $fileName
        }
        
    }
    elseif ($resourceids.count -eq 1) {
        $resourceids = $resourceids.resourceid | ConvertTo-JSON

        Write-host "Resource Ids are: $resourceids"

        $BearerToken = ('Bearer {0}' -f (Get-AzCachedAccessToken))

        $RequestHeader = @{
            "Content-Type"  = "application/json";
            "Authorization" = "$BearerToken"
        }

        $RequestHeader

        $sourcergname = $resourceGroup.ResourceGroupName
        write-host "Source Resource Group is: $sourcergname"

        $targetrgname = $resourceGroup.ResourceGroupName
        write-host "Target Resource Group is: $targetrgname"

        $Body = @"
{
 "resources": [
     $resourceids
     ],
 "targetResourceGroup": "/subscriptions/$targetsub/resourceGroups/$targetrgname"
}
"@
        $Body

        $URI = "https://management.azure.com/subscriptions/$subscriptionid/resourceGroups/$sourcergname/validateMoveResources?api-version=2019-05-10"

        $URI

        $response = Invoke-WebRequest -Uri $URI -Method POST -body $body -header $RequestHeader

        Sleep 120

        $a = $response.rawcontent

        $a

        $checkURI = $a.Substring($a.IndexOf('https:'))

        Write-Host `n"Location URI: $checkURI"
        
        try {
            $CheckResponse = Invoke-WebRequest -Uri $checkURI -Method Get -header $RequestHeader
        }
        catch {
            $fileName = "validation-error-" + $sourcergname + ".json"
            $result = $_.Exception.Response.GetResponseStream()
            $reader = New-Object System.IO.StreamReader($result)
            $reader.BaseStream.Position = 0
            $reader.DiscardBufferedData()
            $responseBody = $reader.ReadToEnd();
            $responseBody | convertfrom-json | convertto-json -depth 100 | out-file $fileName
        }
    }
    elseif ($resourceids -eq $null) {

        $sourcergname = $resourceGroup.ResourceGroupName

        write-host "Source Resource Group $sourcergname does not contain any resources."

        if (test-path .\logs) {
            if (test-path ".\logs\emptyResourceGroups.log") {
                add-content -path ".\logs\emptyResourceGroups.log" -Value "$sourcergname does not contain any resources."
            }
        }
        else {
            new-item -path "." -name "logs" -itemtype "directory"
            new-item -path ".\logs" -name "emptyResourceGroups.log" -itemtype "file"
            add-content -path ".\logs\emptyResourceGroups.log" -Value "$sourcergname does not contain any resources."
        }
    }
}