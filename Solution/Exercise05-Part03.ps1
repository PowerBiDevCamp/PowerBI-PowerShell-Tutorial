Write-Host

Connect-PowerBIServiceAccount | Out-Null

$workspaceName = "Dev Camp Labs"
$datasetName = "COVID-US"

$workspace = Get-PowerBIWorkspace -Name $workspaceName

$dataset = Get-PowerBIDataset -WorkspaceId $workspace.Id | Where-Object Name -eq $datasetName

$workspaceId = $workspace.Id
$datasetId = $dataset.Id

$datasources = Get-PowerBIDatasource -WorkspaceId $workspaceId -DatasetId $datasetId

foreach($datasource in $datasources) {
  
  # parse together REST URL to reference datasource to be patched
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
