Clear-Host
Write-Host

Connect-PowerBIServiceAccount | Out-Null

function ExportDailyActivity($date) {
  
  $start = (Get-Date -Date ($date) -Format yyyy-MM-ddTHH:mm:ss)
  $end = (Get-Date -Date ((($date).AddDays(1)).AddSeconds(-1)) -Format yyyy-MM-ddTHH:mm:ss)
  
  New-Item -ItemType Directory -Force -Path "$PSScriptRoot/logs" | Out-Null

  $dateString = (Get-Date -Date ($date) -Format yyyy-MM-dd)
  $outputFile = "$PSScriptRoot/logs/ActivityEventsLog-$dateString.csv"

  Write-Host "Getting actvities for $dateString"
  $events = Get-PowerBIActivityEvent -StartDateTime $start -EndDateTime $end `
                                     -ResultType JsonString | ConvertFrom-Json

  if($events){
    Write-Host " - Exporting events to $outputFile"
    $events | Export-Csv -Path $outputFile -NoTypeInformation
  }
  else {
    Write-Host " - There was no activity on $dateString"
  }
}

$DaysBack = 3
$DateRange = $DaysBack..0

foreach($dayOffset in $DateRange) {
  $day = (((Get-Date).Date).AddDays(-$dayOffset))
  ExportDailyActivity $day
}
