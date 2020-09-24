Connect-PowerBIServiceAccount | Out-Null

$workspaceName = "Dev Camp Demos"
$datasetName = "COVID-US"

# get object for target workspace
$workspace = Get-PowerBIWorkspace -Name $workspaceName

# get object for new dataset
$dataset = Get-PowerBIDataset -WorkspaceId $workspace.Id | Where-Object Name -eq $datasetName

# determine workspace Id and Dataset Id
$workspaceId = $workspace.Id
$datasetId = $dataset.Id

# parse REST Url for Power BI Service to delete dataset
$restUrl = "groups/$workspaceId/datasets/$datasetId"

# execute HTTP DELETE operation to delete dataset
Invoke-PowerBIRestMethod -Method Delete -Url $restUrl


