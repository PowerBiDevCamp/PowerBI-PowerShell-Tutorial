$workspaceName = "Test Workspace 1"
$datasetName = "COVID-US"

# get object for target workspace
$workspace = Get-PowerBIWorkspace -Name $workspaceName

# get object for new dataset
$dataset = (Get-PowerBIDataset -WorkspaceId $workspace.Id | Where-Object Name -eq $datasetName)

$workspaceId = $workspace.Id
$datasetId = $dataset.Id

Write-Host
Write-Host "The ID for $workspaceName is $workspaceId"
Write-Host "The ID for $datasetName is $datasetId"