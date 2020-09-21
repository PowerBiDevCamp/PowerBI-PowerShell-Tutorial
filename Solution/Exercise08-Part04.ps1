Clear-Host

$summarOutputFile = "$PSScriptRoot/logs/ActivityEventsLogSummary.csv"
Remove-Item $summarOutputFile -Force -ErrorAction Ignore

# combine all CSV file data into single summary file
$csvFiles = Get-ChildItem -Path "$PSScriptRoot/logs" -Filter "ActivityEvents*.csv"

foreach($cvsFile in $csvFiles) {
    $cvsFile | Select-Object -ExpandProperty FullName | Import-Csv -
} 
 
        