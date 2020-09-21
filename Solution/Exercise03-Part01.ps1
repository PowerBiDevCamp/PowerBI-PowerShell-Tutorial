Write-Host

$user = Connect-PowerBIServiceAccount

$newWorkspaceName = "Test Workspace 1"

$workspace = New-PowerBIGroup -Name $newWorkspaceName
