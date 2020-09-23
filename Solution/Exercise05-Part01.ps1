Write-Host

Connect-PowerBIServiceAccount | Out-Null

$workspaceName = "Dev Camp Labs"
$datasetName = "COVID-US"

$workspace = Get-PowerBIWorkspace -Name $newWorkspaceName

$dataset = Get-PowerBIDataset -WorkspaceId $workspace.Id | Where-Object Name -eq $datasetName

$workspaceId = $workspace.Id
$datasetId = $dataset.Id

Write-Host
Write-Host "The ID for $workspaceName is $workspaceId"
Write-Host "The ID for $datasetName is $datasetId"