Clear-Host
# log into Azure AD
# $user = Connect-DataGatewayServiceAccount -Environment Public

Write-Host
Write-Host "Now logged in as $user.UserName"
Write-Host

$gateway = Get-DataGatewayCluster

Write-Host "Found gateway named $gateway.Name"
Write-Host 

$datasources = Get-DataGatewayClusterDatasource -GatewayClusterId $gateway.Id

foreach($datasource in $datasources){
    Write-Host "Datasource: "
    Write-Host $datasource.DatasourceName
    $users = Get-DataGatewayClusterDatasourceUser -GatewayClusterId $gateway.Id -GatewayClusterDatasourceId $datasource.Id
    $users | Format-Table DatasourceUserAccessRight, PrincipalType, DisplayName, Identifier
    Write-Host
}