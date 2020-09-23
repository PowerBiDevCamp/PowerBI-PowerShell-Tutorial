Write-Host

Connect-PowerBIServiceAccount | Out-Null

$workspaceName = "Dev Camp Labs"

$workspace = Get-PowerBIWorkspace -Name $workspaceName

$pbixFilePath = "$PSScriptRoot\SalesByState.pbix"

$importName = "Sales Report for Florida"
$parameterValueState = "FL"

$import = New-PowerBIReport -Path $pbixFilePath -WorkspaceId $workspace.Id `
                            -Name $importName -ConflictAction CreateOrOverwrite

# get object for new dataset
$dataset = Get-PowerBIDataset -WorkspaceId $workspace.Id | Where-Object Name -eq $import.Name

$workspaceId = $workspace.Id
$datasetId = $dataset.Id

# create REST URL to update State parameter for newly-imported dataset
$datasetParametersUrl = "groups/$workspaceId/datasets/$datasetId/Default.UpdateParameters"

# parse together JSON for POST body to update dataset parameters
$postBody = "{updateDetails:[{name:'State', newValue:'$parameterValueState'}]}"

# invoke POST operation to update dataset parameters
Invoke-PowerBIRestMethod -Url:$datasetParametersUrl -Method:Post -Body:$postBody `
                         -ContentType:'application/json'

# get object for new SQL datasource
$datasources = Get-PowerBIDatasource -WorkspaceId $workspaceId -DatasetId $datasetId

Write-Host

foreach($datasource in $datasources) {
  
  $gatewayId = $datasource.gatewayId
  $datasourceId = $datasource.datasourceId
  $datasourePatchUrl = "gateways/$gatewayId/datasources/$datasourceId"

  Write-Host "Patching credentials for $datasourceId"

  # add credentials for SQL datasource
  $sqlUserName = "CptStudent"
  $sqlUserPassword = "pass@word1"

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

  # execute PATCH operation to set datasource credentials
  Invoke-PowerBIRestMethod -Method Patch -Url $datasourePatchUrl -Body $patchBodyJson

}

# parse REST URL for dataset refresh
$datasetRefreshUrl = "groups/$workspaceId/datasets/$datasetId/refreshes"

Write-Host "Starting refresh operation"

# execute POST to begin dataset refresh
Invoke-PowerBIRestMethod -Method Post -Url $datasetRefreshUrl -WarningAction Ignore