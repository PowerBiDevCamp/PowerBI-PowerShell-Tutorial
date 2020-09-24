cls
# log into Azure AD as service principal
$tenantId = "a89a5a60-0169-470a-8032-de9e5e18cdf0"
$applictionId = "c416e7e6-5340-4566-af82-ee6b41608046"
$certificateThumbprint = "013D1747A46063795EFABC70D4AA5D45DB88DD89"


$sp = Connect-DataGatewayServiceAccount -ApplicationId <String>
       -CertificateThumbprint <String>
       [-Tenant <String>]
       [-Environment <PowerBIE

$AppId = $sp.UserName

Write-Host
Write-Host "Logged on as service principal with AppID of $AppId"
Write-Host
