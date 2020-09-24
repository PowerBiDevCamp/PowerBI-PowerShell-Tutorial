
$workspaceName = "Wingtip Sales"
$datasetName = "WingtipSales"

# add credentials for SQL datasource
$sqlUserName = "CptStudent"
$sqlUserPassword = "pass@word1"

# get object for target workspace
$workspace = Get-PowerBIWorkspace -Name $workspaceName

if(!$workspace){ 
  throw "Workspace cannot be found"
}

# get object for new dataset
$dataset = Get-PowerBIDataset -WorkspaceId $workspace.Id | Where-Object Name -eq $datasetName

if(!$dataset){ 
  throw "Dataset cannot be found"
}

$dataset

# parse REST URL to take over dataset
$datasetTakeover = "groups/$workspaceId/datasets/$datasetId/Default.Takeover"

# execute POST to take over dataset
Invoke-PowerBIRestMethod -Method Post -Url $datasetTakeover -WarningAction Ignore

# get object for new SQL datasource
$datasource = Get-PowerBIDatasource -WorkspaceId $workspace.Id -DatasetId $dataset.Id

# parse REST to determine gateway Id and datasource Id
$workspaceId = $workspace.Id
$datasetId = $dataset.Id
$datasourceUrl = "groups/$workspaceId/datasets/$datasetId/datasources"

# execute REST call to determine gateway Id and datasource Id
$datasourcesResult = Invoke-PowerBIRestMethod -Method Get -Url $datasourceUrl | ConvertFrom-Json

# parse REST URL used to patch datasource credentials
$datasource = $datasourcesResult.value[0]
$gatewayId = $datasource.gatewayId
$datasourceId = $datasource.datasourceId
$datasourePatchUrl = "gateways/$gatewayId/datasources/$datasourceId"

# create HTTP request body to patch datasource credentials
$patchBody = @{
  "credentialDetails" = @{
    "credentials" = "{""credentialData"":[{""name"":""username"",""value"":""$sqlUserName""},{""name"":""password"",""value"":""$sqlUserPassword""}]}"
    "credentialType" = "Basic"
    "encryptedConnection" =  "NotEncrypted"
    "encryptionAlgorithm" = "None"
    "privacyLevel" = "Organizational"
  }
}

# convert body contents to JSON
$patchBodyJson = ConvertTo-Json -InputObject $patchBody -Depth 6 -Compress

# execute PATCH request to set datasource credentials
Invoke-PowerBIRestMethod -Method Patch -Url $datasourePatchUrl -Body $patchBodyJson

# parse REST URL for dataset refresh
$datasetRefreshUrl = "groups/$workspaceId/datasets/$datasetId/refreshes"

# execute POST to begin dataset refresh
Invoke-PowerBIRestMethod -Method Post -Url $datasetRefreshUrl -WarningAction Ignore
