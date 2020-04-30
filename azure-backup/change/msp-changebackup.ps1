#Define deployment parameters
$SubID = Read-Host "Enter the customer's Subscription ID"
$RGName = Read-Host "Enter the name of the Recovery Services Vault Resource Group"
$RSVName = Read-Host "Enter the name of the Recovery Services Vault"
$PolName = Read-Host "Enter the name of the Backup Policy to modify"
$Vault = Get-AzRecoveryServicesVault -ResourceGroupName $RGName -Name $RSVName

#Log into CSP tenant using interactive credentials
Connect-AzAccount -Subscription $SubID

##Change the backup retention settings
$BackupRet = Get-AzRecoveryServicesBackupRetentionPolicyObject -WorkloadType "AzureVM"
$BackupRet.DailySchedule.DurationCountInDays = 7
$BackupRet.IsWeeklyScheduleEnabled = $false
$BackupRet.MonthlySchedule.DurationCountInMonths = 12
$BackupRet.MonthlySchedule.RetentionScheduleWeekly.WeeksOfTheMonth = 'Third'
$BackupRet.IsYearlyScheduleEnabled = $false
$BackupPol = Get-AzRecoveryServicesBackupProtectionPolicy -Name $PolName -VaultId $Vault.ID

#Update the backup policy
Set-AzRecoveryServicesBackupProtectionPolicy -VaultId $Vault.ID -Policy $BackupPol -RetentionPolicy $BackupRet

#Update the Vault's redundancy to GeoRedundant
Set-AzRecoveryServicesBackupProperties -Vault $Vault -BackupStorageRedundancy GeoRedundant
