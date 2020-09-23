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
$pbixFilePath = "C:\DevCamp\PBIX\COVID-US.pbix"

$import = New-PowerBIReport -Path $pbixFilePath -Workspace $workspace

$import | select *