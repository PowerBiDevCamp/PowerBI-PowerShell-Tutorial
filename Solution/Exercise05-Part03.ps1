$workspaceName = "Test Workspace 1"
$datasetName = "COVID-US"

# get object for target workspace
$workspace = Get-PowerBIWorkspace -Name $workspaceName

# get object for new dataset
$dataset = Get-PowerBIDataset -WorkspaceId $workspace.Id | Where-Object Name -eq $datasetName

$workspaceId = $workspace.Id
$datasetId = $dataset.Id

# get object for new SQL datasource
$datasources = Get-PowerBIDatasource -WorkspaceId $workspaceId -DatasetId $datasetId

Write-Host 

foreach($datasource in $datasources) {
  
  $gatewayId = $datasource.gatewayId
  $datasourceId = $datasource.datasourceId
  $datasourePatchUrl = "gateways/$gatewayId/datasources/$datasourceId"

  Write-Host "Patching credentials for $datasourceId"

  # create HTTP request body to patch datasource credentials
  $patchBody = @{
    "credentialDetails" = @{
      "credentials" = "{""credentialData"":""""}"
      "credentialType" = "Anonymous"
      "encryptedConnection" =  "NotEncrypted"
      "encryptionAlgorithm" = "None"
      "privacyLevel" = "Public"
    }
  }

  # convert body contents to JSON
  $patchBodyJson = ConvertTo-Json -InputObject $patchBody -Depth 6 -Compress

  # execute PATCH operation to set datasource credentials
  Invoke-PowerBIRestMethod -Method Patch -Url $datasourePatchUrl -Body $patchBodyJson

}
