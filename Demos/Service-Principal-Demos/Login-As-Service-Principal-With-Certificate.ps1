cls
# log into Azure AD as service principal
$tenantId = "ADD_TENANT_ID"
$applictionId = "ADD_APPLICATION_ID"
$certificateThumbprint = "ADD_APPLICATION_CERTIFICATE_THUMBPRINT"

$sp = Connect-PowerBIServiceAccount -ServicePrincipal -Tenant $tenantId -ApplicationId $applictionId -CertificateThumbprint $certificateThumbprint

$AppId = $sp.UserName

Write-Host
Write-Host "Logged on as service principal with AppID of $AppId"
Write-Host
