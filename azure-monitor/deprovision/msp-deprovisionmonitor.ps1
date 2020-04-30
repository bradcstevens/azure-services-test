#Check for the presence of the Az.Monitor module; install/import if not found, import if found
$MonitorModule = (Get-Module -Name Az.Monitor).Name

if ($MonitorModule -like "Az.Monitor") {
    Import-Module -Name Az.Monitor
    }
else {
    Install-Module -Name Az.Monitor -AllowClobber -Force
    Import-Module -Name Az.Monitor
    }

#Define the ID for the test subscription
$MSPSub = "dd2c542a-aeaf-4cef-9ccd-e89ae5864c3f"

#Log into CSP tenant using interactive credentials
Connect-AzAccount -Subscription $MSPSub

#Define deployment parameters
$RGName = "msp-rsarg-monitor"

#Delete the resource group
Remove-AzureRMResourceGroup -Name $RGName -Force


#If needed, we can remove rules, settings, alerts, and action groups independently. Isolating Monitor resources to a specific Resource Group
#and simply removing the Resource Group is still the best and recommended method for easy resource cleanup.
#
#$AlertRules = Get-AzMetricAlertRuleV2 -ResourceGroupName $RGName
#
#foreach ($AlertRule in $AlertRules) {
#    Remove-AzMetricAlertRuleV2 -ResourceGroupName $RGName -Name $AlertRule -PassThru
#    }
#
#Get-AzAutoscaleSetting -ResourceGroupName $RGName | Remove-AzAutoscaleSetting
#Get-AzScheduledQueryRule -ResourceGroupName $RGName | Remove-AzScheduledQueryRule -PassThru
#Get-AzAutoscaleSetting -ResourceGroupName $RGName | Remove-AzAutoscaleSetting
#Get-AzActionGroup -ResourceGroupName $RGName | Remove-AzActionGroup
