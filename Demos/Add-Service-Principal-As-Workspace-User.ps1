# Connect-PowerBIServiceAccount 

$workspaceName = "Dev Camp Demos 3"

$servicePrincipalId = "c4143c3d-e853-42c5-a0ee-3eceac680305"

# get target workspace
$workspace = Get-PowerBIWorkspace -Name $workspaceName

Add-PowerBIWorkspaceUser -Scope Organization `
                         -Id $workspace.Id `
                         -AccessRight Admin `
                         -Identifier $servicePrincipalId `
                         -PrincipalType App