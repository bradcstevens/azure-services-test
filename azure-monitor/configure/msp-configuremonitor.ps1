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
$AlertCondition = New-AzMetricAlertRuleV2Criteria -MetricName "Percentage CPU" -MetricNamespace "Microsoft.Compute/virtualMachines" -TimeAggregation Average -Operator GreaterThan -Threshold 1
$ActionGroup = New-AzActionGroup -ActionGroupId (Get-AzActionGroup -ResourceGroupName $RGName).Id
$ActionEmail = New-AzAlertRuleEmail -CustomEmail rossarg@cdw.com

$VMScaleSet = "/subscriptions/dd2c542a-aeaf-4cef-9ccd-e89ae5864c3f/resourceGroups/MSP-RSARG-MONITOR/providers/Microsoft.Compute/virtualMachineScaleSets/mspscaleset"
$ASRule1 = New-AzAutoscaleRule -MetricName "Percentage CPU" -MetricResourceId $VMResourceID -Operator GreaterThan -MetricStatistic Average -Threshold 3 -TimeGrain 00:01:00 -ScaleActionCooldown 00:05:00 -ScaleActionDirection Increase -ScaleActionScaleType ChangeCount -ScaleActionValue "1" 
$ASProfile1 = New-AzAutoscaleProfile -DefaultCapacity "1" -MaximumCapacity "2" -MinimumCapacity "1" -Rule $ASRule1 -Name "Scale Up Profile"

#Create a metric alert which pushes alerts to an email address
Add-AzMetricAlertRuleV2 -Name vmcpu_gt_1 -ResourceGroupName $RGName -TargetResourceId $VMResourceID -Condition $AlertCondition -WindowSize 0:5 -Frequency 0:5 -Description "Send an email when average CPU is greater than 1% over five minutes." -Severity 3 -ActionGroup $ActionGroup

#Create an autoscaling action
Add-AzAutoscaleSetting -Location "North Central US" -Name "MSP Auto Scale Test Settings" -ResourceGroupName $RGName -TargetResourceId $VMScaleSet -AutoscaleProfile $ASProfile1
