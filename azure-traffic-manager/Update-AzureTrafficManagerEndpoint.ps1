$TrafficManagerEndpoint = Get-AzTrafficManagerEndpoint -Name "MyPrimaryEndpoint" -Type AzureEndpoints -ProfileName "Chartrafficmanager" -ResourceGroupName "N-COMPUTE-VMSSRG"
$TrafficManagerEndpoint.Weight = 20
Set-AzTrafficManagerEndpoint -TrafficManagerEndpoint $TrafficManagerEndpoint