Write-Host

#$user = Connect-PowerBIServiceAccount

$newWorkspaceName = "Test Workspace 1"

$workspace = Get-PowerBIWorkspace -Name $newWorkspaceName

if($workspace) {
  Write-Host "The workspace named $newWorkspaceName already exists"
}
else {
  Write-Host "Creating new workspace named $newWorkspaceName"
  $workspace = New-PowerBIGroup -Name $newWorkspaceName
}

# determine path to PBIX file
$pbixFilePath = "C:\DevCamp\PBIX\SalesByState.pbix"

$importName = "Sales Report for Washington"
$parameterValueState = "WA"


$import = New-PowerBIReport -Path $pbixFilePath -WorkspaceId $workspace.Id -Name $importName -ConflictAction CreateOrOverwrite

# get object for target workspace
$workspace = Get-PowerBIWorkspace -Name $workspaceName

# get object for new dataset
$dataset = Get-PowerBIDataset -WorkspaceId $workspace.Id | Where-Object Name -eq $import.Name

$workspaceId = $workspace.Id
$datasetId = $dataset.Id


# update State parameter for newly-imported dataset
$datasetParametersUrl = "groups/$workspaceId/datasets/$datasetId/Default.UpdateParameters"

$postBody = "{updateDetails:[{name:'State', newValue:'$parameterValueState'}]}"

Invoke-PowerBIRestMethod -Url:$datasetParametersUrl -Method:Post -Body:$postBody -ContentType:'application/json' | ConvertFrom-Json

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