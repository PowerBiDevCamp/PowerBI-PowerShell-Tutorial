
$workspaceName = "Wingtip Sales"
$datasetName = "Gateway Test"


# get object for target workspace
$workspace = Get-PowerBIWorkspace -Name $workspaceName

if(!$workspace){ 
  throw "Workspace cannot be found"
}
# get workspace ID
$workspaceId  = $workspace.Id

# get object for new dataset
$dataset = Get-PowerBIDataset -WorkspaceId $workspace.Id | Where-Object Name -eq $datasetName

if(!$dataset){ 
  throw "Dataset cannot be found"
}

# determine dataset ID
$datasetId = $dataset.Id

# parse REST URL to take over dataset
$datasetTakeover = "groups/$workspaceId/datasets/$datasetId/Default.Takeover"

# execute POST to take over dataset
Invoke-PowerBIRestMethod -Method Post -Url $datasetTakeover -WarningAction Ignore


# parse REST URL for dataset refresh
$datasetRefreshUrl = "groups/$workspaceId/datasets/$datasetId/refreshes"

# execute POST to begin dataset refresh
Invoke-PowerBIRestMethod -Method Post -Url $datasetRefreshUrl -WarningAction Ignore
