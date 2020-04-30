#Define the subscription's ID
$MSPSub = "dd2c542a-aeaf-4cef-9ccd-e89ae5864c3f"

#Log into CSP tenant using interactive credentials
Connect-AzureRmAccount -Subscription $MSPSub

#Define deployment parameters
$RGName = "msp-rsarg-azuredns"
$ZoneName = "mspazurecdw.com"
$MXRecordSet = Get-AzureRmDnsRecordSet -ResourceGroupName $RGName -ZoneName $ZoneName -Name mail -RecordType MX
$WWWRecordSet = Get-AzureRmDnsRecordSet -ResourceGroupName $RGName -ZoneName $ZoneName -Name www -RecordType A
$CNAMERecordSet = Get-AzureRmDnsRecordSet -ResourceGroupName $RGName -ZoneName $ZoneName -Name portal -RecordType CNAME
$MXValue = "mail2.mspazurecdw.com"
$WWWValue = "1.2.3.5"
$CNAMEOldValue = "webapp.mspazurecdw.com"
$CNAMENewValue = "customapp.mspazurecdw.com"

#Add the updated MX record entry
Add-AzureRmDnsRecordConfig -RecordSet $MXRecordSet -Exchange $MXValue -Preference 2
Set-AzureRmDnsRecordSet -RecordSet $MXRecordSet

#Remove an A record from the WWW record set
Remove-AzureRmDnsRecordConfig -RecordSet $WWWRecordSet -Ipv4Address $WWWIpV4Address
Set-AzureRmDnsRecordSet -RecordSet $WWWRecordSet

#Update the CNAME record from the CNAME record set
Remove-AzureRmDnsRecordConfig -RecordSet $CNAMERecordSet -Cname $CNAMEOldValue
Add-AzureRmDnsRecordConfig -RecordSet $CNAMERecordSet -Cname $CNAMENewValue
Set-AzureRmDnsRecordSet -RecordSet $CNAMERecordSet
