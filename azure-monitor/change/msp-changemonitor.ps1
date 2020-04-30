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
$VMResourceID = "/subscriptions/dd2c542a-aeaf-4cef-9ccd-e89ae5864c3f/resourceGroups/msp-rsarg-monitor/providers/Microsoft.Compute/virtualMachines/msp-rsarg-test"
$AlertCondition2 = New-AzMetricAlertRuleV2Criteria -MetricName "CPU Credits Remaining" -MetricNamespace "Microsoft.Compute/virtualMachines" -Threshold 50 -Operator LessThan -TimeAggregation Count
$ActionGroup = New-AzActionGroup -ActionGroupId (Get-AzActionGroup -ResourceGroupName $RGName).Id
$ActionEmail = New-AzAlertRuleEmail -CustomEmail rossarg@cdw.com


$VMScaleSetId = "/subscriptions/dd2c542a-aeaf-4cef-9ccd-e89ae5864c3f/resourceGroups/MSP-RSARG-MONITOR/providers/Microsoft.Compute/virtualMachineScaleSets/mspscaleset"
$ASRule2 = New-AzAutoscaleRule -MetricName "Network In Total" -MetricResourceId $VMScaleSetId -Operator GreaterThan -MetricStatistic Average -Threshold 10240 -TimeGrain 00:01:00 -ScaleActionCooldown 00:05:00 -ScaleActionDirection Increase -ScaleActionScaleType ChangeCount -ScaleActionValue "1" 
$ASProfile2 = New-AzAutoscaleProfile -DefaultCapacity "1" -MaximumCapacity "3" -MinimumCapacity "1" -Rule $ASRule2 -Name "Scale Up (Network) Profile"

#Add an additional metric alert which pushes alerts to an email address

Add-AzMetricAlertRuleV2 -Name vmcpucredit_lt_50 -ResourceGroupName $RGName -TargetResourceId $VMResourceID -Condition $AlertCondition2 -WindowSize 0:5 -Frequency 0:5 -Description "Send an email when remaining CPU credits falls below 50." -Severity 3 -ActionGroup $ActionGroup

#Replace an autoscaling action
Remove-AzAutoscaleSetting -Name "MSP Auto Scale Test Settings" -ResourceGroupName $RGName
Add-AzAutoscaleSetting -Location "North Central US" -Name "MSP Auto Scale Test2 Settings" -ResourceGroupName $RGName -TargetResourceId $VMScaleSetId -AutoscaleProfile $ASProfile2
