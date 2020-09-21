Clear-Host

$summarOutputFile = "$PSScriptRoot/logs/ActivityEventsLogSummary.csv"

$headers = "Id,RecordType,CreationTime,Operation,OrganizationId,UserType,UserKey,Workload,UserId,ClientIP,UserAgent,Activity,IsSuccess,FolderObjectId,FolderDisplayName,FolderAccessRequests,RequestId,ActivityId"
$headers | Out-File $summarOutputFile

$csvFiles = Get-ChildItem -Path "$PSScriptRoot/logs" -Filter "ActivityEvents*.csv"| Select-Object -ExpandProperty FullName 

foreach($csvFile in $csvFiles) {
Write-Host " -- "
  $csvFile | Import-Csv | Export-Csv $summarOutputFile -Append
} 
        