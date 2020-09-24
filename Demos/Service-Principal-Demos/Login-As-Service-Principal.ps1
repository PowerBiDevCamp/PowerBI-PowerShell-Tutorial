
# log into Azure AD as service principal
$tenantId = "ADD_TENANT_ID"
$applictionId = "ADD_APPLICATION_ID"
$applicationSecret = "ADD_APPLICATION_SECRET"

$SecuredApplicationSecret = ConvertTo-SecureString -String $applicationSecret -AsPlainText -Force
$credential = New-Object -TypeName System.Management.Automation.PSCredential `
                         -ArgumentList $applictionId, $SecuredApplicationSecret

$sp = Connect-PowerBIServiceAccount -ServicePrincipal -Tenant $tenantId -Credential $credential

$AppId = $sp.UserName

Write-Host
Write-Host "Logged on as service principal with AppID of $AppId"
Write-Host

