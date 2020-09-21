$user = Connect-PowerBIServiceAccount

$tenantId = $user.TenantId

$outputFile = "$PSScriptRoot/WorkspaceReport.txt"

"Report of V2 Workspaces in Tenant $tenantId `n" | Out-File $outputFile

$workspaces = Get-PowerBIWorkspace -Scope Organization -Filter "(type eq 'Workspace') and (state eq 'Active')" -Include All

foreach($workspace in $workspaces) {
  $workspaceName = $workspace.Name
  $workspaceId = $workspace.Id
  "Workspace: $workspaceName ($workspaceId)" | Out-File $outputFile -Append

  " - Users:" | Out-File $outputFile -Append
  foreach($user in $workspace.Users){
    $userId = $user.Identifier
    $userAccessRight = $user.AccessRight
    "   - $userId ($userAccessRight)" | Out-File $outputFile -Append
  }

  " - Datasets:" | Out-File $outputFile -Append
  foreach($dataset in $workspace.Datasets){
  $dataset | select *
    $datasetName = $dataset.Name
    $datasetId = $dataset.Id
    $ConfiguredBy = $dataset.ConfiguredBy
    $ContentProviderType = $dataset.ContentProviderType
    "   - $datasetName ($datasetId) - $ContentProviderType - Configured by $ConfiguredBy " | Out-File $outputFile -Append
  }

  " - Reports:" | Out-File $outputFile -Append
  foreach($report in $workspace.Reports){
    $reportName = $report.Name
    $reportId = $report.Id
    $datasetId = $report.DatasetId
    "   - $reportName (ReportId:$reportId - DatasetId:$datasetId) " | Out-File $outputFile -Append
  }

  "`n------------------`n" | Out-File $outputFile -Append
}

notepad.exe $outputFile