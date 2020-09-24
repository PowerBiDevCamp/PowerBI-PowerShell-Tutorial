# Requires running Install-Module -Name DataGateway

$gateway = Get-DataGatewayCluster
$gatewayId = $gateway.Id

$urlGatewayUsers = "gateways/$gatewayId/datasources"



$usersResult = Invoke-PowerBIRestMethod -Method Get -Url $urlGatewayUsers | ConvertFrom-Json

$usersResult