Connect-PowerBIServiceAccount | Out-Null

# modify name of target workspace if needed
$workspaceName = "Dev Camp Labs"

# modify name and path of model.json file if needed
$DataflowImportFileName = "$PSScriptRoot\model.json"

# read JSON from model.json into locale variable
$DataflowDefinition = [IO.File]::ReadAllText($DataflowImportFileName)

Connect-PowerBIServiceAccount
$UserAccessToken = Get-PowerBIAccessToken
$bearer = $UserAccessToken.Authorization.ToString()

# get workspace ID from workspace name
$workspace = Get-PowerBIWorkspace -Name $workspaceName
$workspaceId = $workspace.Id

# construct URL to import model.json - Note datasetDisplayName must be hard-coded to "model.json"
$importsUrl = "https://api.powerbi.com/v1.0/myorg/groups/$workspaceId/imports?datasetDisplayName=model.json"

$boundary = [System.Guid]::NewGuid().ToString("N")
$LF = [System.Environment]::NewLine

$contentType = "multipart/form-data; boundary=""$boundary"""

$body = (
 "--$boundary",
 "Content-Disposition: form-data $LF",
 $DataflowDefinition,
 "--$boundary--$LF"
) -join $LF

$headers = @{
  'Authorization' = "$bearer"
  'Content-Type' = "$contentType"
}

Invoke-RestMethod -Uri $importsUrl -ContentType $contentType -Method POST -Headers $headers -Body $body