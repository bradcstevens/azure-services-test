#Define deployment parameters
$SubID = Read-Host "Enter the customer's Subscription ID"
$RGName = Read-Host "Enter the name of the Recovery Services Vault Resource Group"
$RSVName = Read-Host "Enter the name of the Recovery Services Vault"
$PolName = Read-Host "Enter the name for the new Backup Policy"
$Vault = Get-AzRecoveryServicesVault -ResourceGroupName $RGName -Name $RSVName

#Log into customer's tenant using interactive credentials
Connect-AzAccount -Subscription $SubID

#Define backup policy settings
$BackupSch = Get-AzRecoveryServicesBackupSchedulePolicyObject -WorkloadType "AzureVM"
$BackupSch.ScheduleRunTimes.Clear()
$Date = Get-Date
$Date = Get-Date -Year $Date.Year -Month $Date.Month -Day $Date.Month -Hour $Date.Hour -Minute 0 -Second 0 -Millisecond 0
$BackupSch.ScheduleRunTimes.Add($Date.ToUniversalTime())
$BackupRet = Get-AzRecoveryServicesBackupRetentionPolicyObject -WorkloadType "AzureVM"
$BackupRet.DailySchedule.DurationCountInDays = 45
$BackupRet.WeeklySchedule.DurationCountInWeeks = 12
$BackupRet.MonthlySchedule.DurationCountInMonths = 6
$BackupRet.YearlySchedule.DurationCountInYears = 1

#Create the backup policy
New-AzRecoveryServicesBackupProtectionPolicy -Name $PolName -VaultId $Vault.ID -WorkloadType "AzureVM" -SchedulePolicy $BackupSch -RetentionPolicy $BackupRet

####Only use this portion for real deployments
##Attach the backup policy to a VM
#$BackupPol = Get-AzRecoveryServicesBackupProtectionPolicy -Name $PolName
#Enable-AzRecoveryServicesBackupProtection -Policy $BackupPol -ResourceGroupName $RGName -Name $VMName

####To disable the default "Soft Delete" property of a Recovery Services Vault, we need to run the following commands.
##Check for the presence of the Az.RecoveryServices module; install/import if not found, import if found
#$RSVModule = (Get-Module -Name Az.RecoveryServices).Name
#
#if ($RSVModule -like "Az.RecoveryServices") {
#    Import-Module -Name Az.RecoveryServices
#    }
#else {
#    Install-Module -Name Az.RecoveryServices -AllowClobber -Force
#    Import-Module -Name Az.RecoveryServices
#    }
#
##Define the subscription's ID
#$SubID = Read-Host "Enter the customer's Subscription ID"
#
##Log into CSP tenant using interactive credentials
#Connect-AzAccount -Subscription $SubID
#
##Disable "Soft Delete" in the Recovery Services Vault
#$Vault = Get-AzRecoveryServicesVault -ResourceGroupName $RGName -Name $RSVName
#Set-AzRecoveryServicesVaultProperty -VaultId $Vault.ID -SoftDeleteFeatureState Disable
