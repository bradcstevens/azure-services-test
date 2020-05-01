param(
    [string]$SampleFolder = $ENV:SAMPLE_FOLDER, # this is the path to the sample
    [string]$SampleName = $ENV:SAMPLE_NAME,  # the name of the sample or folder path from the root of the repo e.g. "sample-type/sample-name"
    [string] $ReadMeFileName = "README.md"
)

<#
TODO linting - is there a pipeline tool for this ?
#>

$s = $sampleName.Replace("\", "/")

$badges = @(

)
#$badges.Replace("#sampleName#", $sampleName.Replace("\", "/"))

$buttons = @(

)
#$buttons.Replace("#sampleName#", $sampleName.Replace("\", "/"))

Write-Output "Testing file: $SampleFolder/$ReadMeFileName"
$readme = Get-Content "$SampleFolder/$ReadMeFileName" -Raw

$dumpHelp = $false
# header on first line
if(-not ($readme.StartsWith("# "))){
    Write-Error "Readme must start with # header, not: $($readme[0])"
}

#proper src attribute for badges
foreach($badge in $badges){
    if(-not ($readme -clike "*$badge*")){
        $dumpHelp = $true
        Write-Error "Readme is missing badge: $badge"
    }
}

#Proper href and src attribute for buttons
foreach($button in $buttons){
    if(-not ($readme -clike "*$button*")){
        $dumpHelp = $true
        Write-Error "Readme button incorrect HREF or SRC attribute: $button"
    }
}

if( $dumpHelp ){
    $md = @"

    
"@

    Write-Output "Ensure the following markdown is at the top of the README under the heading:`n"
    Write-Output $md

}
