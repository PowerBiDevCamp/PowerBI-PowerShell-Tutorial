Write-Host

Connect-PowerBIServiceAccount | Out-Null

$workspaceName = "Dev Camp Labs"

$workspace = Get-PowerBIWorkspace -Name $workspaceName

$pbixFilePath = "$PSScriptRoot\SalesByState.pbix"

$importName = "Sales Report for California"

$import = New-PowerBIReport -Path $pbixFilePath -WorkspaceId $workspace.Id `
                            -Name $importName -ConflictAction CreateOrOverwrite

# get object for new dataset
$dataset = Get-PowerBIDataset -WorkspaceId $workspace.Id | Where-Object Name -eq $import.Name

$workspaceId = $workspace.Id
$datasetId = $dataset.Id