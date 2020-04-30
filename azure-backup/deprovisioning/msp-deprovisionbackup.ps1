#Define deployment parameters
$SubID = Read-Host "Enter the customer's Subscription ID"
$RGName = Read-Host "Enter the name of the Recovery Services Vault Resource Group"

#Log into CSP tenant using interactive credentials
Connect-AzAccount -Subscription $SubID

#Delete the resource group
Remove-AzResourceGroup -Name $RGName -Force

###If piecemeal removal is needed, we can use the following commands:
##Define deployment parameters
#$RSVName = Read-Host "Enter the name of the Recovery Services Vault"
#$Vault = Get-AzRecoveryServicesVault -ResourceGroupName $RGName -Name $RSVName
#
##Use this section to disable protection of Azure-based VM workloads
#$AzBkupCont = Get-AzRecoveryServicesBackupContainer -VaultId $Vault.ID -ContainerType AzureVM -Status Registered
#$ProtItems = Get-AzRecoveryServicesBackupItem -VaultId $Vault.ID -Container $AzBkupCont[0] -WorkloadType AzureVM
#Disable-AzmRecoveryServicesBackupProtection -VaultId $Vault.ID -Item $ProtItems[0]
#
##Use this section to remove on-premise protected data; this command is run from MARS Agent servers and from a MABS server
#Get-OBPolicy | Remove-OBPolicy -DeleteBackup -SecurityPIN <Security Pin>
#
##Use this section to unregister on-premise Windows Server containers from the Recovery Services Vault
#$OnPremBkupCont = Get-AzRecoveryServicesBackupContainer -VaultId $Vault.ID -ContainerType Windows -BackupManagementType MARS
#Unregister-AzRecoveryServicesBackupContainer -VaultId $Vault.ID -Container $OnPremBkupCont[0]
#
##Use this section to unregister an on-premise MABS Server from the Recovery Services Vault
#$MABSServer = Get-AzRecoveryServicesBackupManagementServer -VaultId $Vault.ID -Name <Name of MABS Server>
#Unregister-AzRecoveryServicesBackupManagementServer -AzureRmBackupManagementServer $MABSServer
#
##Use this section to delete the Recovery Services Vault
##Note that you cannot immediately delete a Recovery Services Vault if the soft delete option was left enabled by default when protecting data.
##Admins will need to wait 14 days before they can delete the Vault entirely after the soft delete window expires.
#Remove-AzRecoveryServicesVault -Vault $Vault
