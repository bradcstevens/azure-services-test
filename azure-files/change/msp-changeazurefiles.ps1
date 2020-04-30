#Define the ID for the test subscription
$MSPSub = "dd2c542a-aeaf-4cef-9ccd-e89ae5864c3f"

#Log into CSP tenant using interactive credentials
Connect-AzureRmAccount -Subscription $MSPSub

#Define deployment parameters
$RGName = "msp-rsarg-files"
$SAName = "msprsargfiles"
$PremSAName = "msprsargpremfiles"

#Upgrade the Storage Account from GenPurpose v1 to v2
Set-AzureRMStorageAccount -ResourceGroupName $RGName -Name $SAName -UpgradeToStorageV2

#Set Access Tier to Cool after the v2 upgrade
Set-AzureRMStorageAccount -ResourceGroupName $RGName -Name $SAName -AccessTier Cool

#Swap Storage Accounts to a new performance tier on the Storage Account
$SAKey = (Get-AzureRmStorageAccountKey -ResourceGroupName $RGName -Name $SAName | Where-Object {$_.KeyName -eq "key1"}).Value
$Context = New-AzureStorageContext -StorageAccountName $SAName -StorageAccountKey $SAKey

New-AzStorageAccount -ResourceGroupName $RGName -Name $PremSAName -SkuName Premium_LRS -Kind "FileStorage" -Location "northcentralus"

$PremSAKey = (Get-AzureRmStorageAccountKey -ResourceGroupName $RGName -Name $PremSAName | Where-Object {$_.KeyName -eq "key1"}).Value
$PremContext = New-AzureStorageContext -StorageAccountName $PremSAName -StorageAccountKey $PremSAKey

$srcshare = (Get-AzureStorageShare -Context $Context).Name
$destshare = (Get-AzureStorageShare -Context $PremContext).Name

New-AzureStorageShare -Name "msp-rsarg-premshare" -Context $PremContext

#####
#####  It's this section that's messing me up. It can populate the list of files, but it doesn't copy files outside of the root into the new directory properly.
#####  It generates the directories, but it creates and puts a "Microsoft.WindowsAzure.Storage.File.CloudFileDirectory" object at the root level in place of the files it should
#####  see within the source directories.
#####

#Establish a list of directories in the source share
$srcdirs = (Get-AzureStorageFile -ShareName $srcshare -Path (Where-Object {$_.Name -like ""}) -Context $Context) | Where-Object {$_.GetType().Name -eq "CloudFileDirectory"}

foreach ($srcdir in $srcdirs) {
       New-AzureStorageDirectory -ShareName $destshare -Context $PremContext -Path $srcdir.Name
       $destdir = (Get-AzureStorageFile -ShareName $destshare -Context $PremContext -Path $srcdir.Name)
       $dirsrcfiles = Get-AzureStorageFile -ShareName $srcshare -Context $Context | Get-AzureStorageFile | Where {$_.GetType().Name -eq "CloudFile"}
       foreach ($dirsrcfile in $dirsrcfiles) {
# When this command attempts to run, it consistently generes the "Microsoft.WindowsAzure.Storage.File.CloudFileDirectory" object in the wrong location, and without the name I'm expeting from 
# "Start-AzureStorageFileCopy : The remote server returned an error: (404) Not Found. HTTP Status Code: 404 - HTTP Error Message: The specified resource does not exist."
            Start-AzureStorageFileCopy -SrcFile $dirsrcfile -DestShareName $destshare -DestFilePath $destdir -DestContext $PremContext -Force
            
            
            #Start-AzureStorageFileCopy -Context $Context -SrcShareName $srcshare -SrcFilePath $srcdir -DestContext $PremContext -DestShareName $destshare -DestFilePath $destdir
            }
       }

#####
#####
#####
#####
#####

$srcfiles = Get-AzureStorageFile -ShareName $srcshare -Context $Context | Where {$_.GetType().Name -eq "CloudFile"}

foreach ($srcfile in $srcfiles) {
    Start-AzureStorageFileCopy -SrcFile $srcfile -DestContext $PremContext -DestShareName $destshare -DestFilePath $srcfile.Name
    }
