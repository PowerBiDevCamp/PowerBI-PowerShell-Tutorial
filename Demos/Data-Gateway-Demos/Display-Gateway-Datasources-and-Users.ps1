
# this script assume tenant only has a single gateway (aka gateway cluster)
$gateway = Get-DataGatewayCluster 

Write-Host "Found gateway named "$gateway.Name
Write-Host 

$datasources = Get-DataGatewayClusterDatasource -GatewayClusterId $gateway.Id

foreach($datasource in $datasources){
    Write-Host "Datasource: "$datasource.DatasourceName
    $users = Get-DataGatewayClusterDatasourceUser -GatewayClusterId $gateway.Id -GatewayClusterDatasourceId $datasource.Id
    $users | Format-Table DatasourceUserAccessRight, PrincipalType, DisplayName, Identifier
    Write-Host
}