# requires PowerShell Core - this script will not work on PowerShell 5
# requires installiing DataGateway PowerShell module: Install-Module -Name DataGateway 

# login as user with admn permissions on gateway
Connect-DataGatewayServiceAccount -Environment Public

# determine service principal ID of application - this is not application ID
$servicePrincipalObjectId = "d26f4381-438a-469e-900e-129c75f2ed60"

# this script assumes tenant has single gateway (aka gateway cluster)
$gateway = Get-DataGatewayCluster 

Add-DataGatewayClusterUser -GatewayClusterId $gateway.Id -PrincipalObjectId $servicePrincipalObjectId -Role Admin 