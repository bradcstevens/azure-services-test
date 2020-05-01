
# this must be run from the "test" folder

$releaseFiles = "..\..\arm-ttk\arm-ttk", ".\ci-scripts", "..\Deploy-AzTemplate.ps1"

Compress-Archive -DestinationPath $ttkFileName -Path $releaseFiles -Force

### Temp step for AMP backward compat
Copy-Item "..\..\arm-ttk\arm-ttk" -Destination ".\template-tests" -Recurse
$releaseFiles += ".\template-tests"
$releaseFiles = $releaseFiles -ne "..\..\arm-ttk/arm-ttk"
Compress-Archive -DestinationPath "AzTemplateToolkit.zip" -Path $releaseFiles -Force
Remove-Item ".\template-tests" -Recurse
### End Temp step