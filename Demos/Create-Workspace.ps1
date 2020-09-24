Write-Host

Connect-PowerBIServiceAccount | Out-Null

$workspaceName = "Dev Camp Labs"

$workspace = New-PowerBIGroup -Name $workspaceName

$workspace | select *