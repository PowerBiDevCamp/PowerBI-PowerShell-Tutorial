# requires PowerShell Core - this script will not work on PowerShell 5
# requires installiing DataGateway PowerShell module: Install-Module -Name DataGateway 
# this script assume tenant only has a single gateway (aka gateway cluster)

Connect-DataGatewayServiceAccount

$gateway = Get-DataGatewayCluster 
$gatewayName = $gateway.Name

Write-Host "Found data gateway named $gatewayName"
Write-Host 

$datasources = Get-DataGatewayClusterDatasource -GatewayClusterId $gateway.Id

foreach($datasource in $datasources){
    Write-Host "Datasource: "$datasource.DatasourceName
    $users = Get-DataGatewayClusterDatasourceUser -GatewayClusterId $gateway.Id -GatewayClusterDatasourceId $datasource.Id
    $users | Format-Table DatasourceUserAccessRight, PrincipalType, DisplayName, Identifier
    Write-Host
}