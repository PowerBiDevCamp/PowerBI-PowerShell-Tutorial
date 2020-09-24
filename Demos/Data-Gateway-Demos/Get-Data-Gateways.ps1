# requires PowerShell Core - this script will not work on PowerShell 5
# requires installiing DataGateway PowerShell module: Install-Module -Name DataGateway 

Connect-DataGatewayServiceAccount

$dataGateways = Get-DataGatewayCluster

$dataGateways | select *