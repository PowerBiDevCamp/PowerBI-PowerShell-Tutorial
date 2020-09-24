
# log into Azure AD as service principal
$tenantId = "e60e3ff3-1c14-4f63-aca4-d30475c0a3d1"
$applictionId = "50b0f8ac-0b31-4098-a139-48e339148b41"
$applicationSecret = "PY3VlZs.2_G65mui227~Xm_5-5X41~02ic"

$SecuredApplicationSecret = ConvertTo-SecureString -String $applicationSecret -AsPlainText -Force
$credential = New-Object -TypeName System.Management.Automation.PSCredential `
                         -ArgumentList $applictionId, $SecuredApplicationSecret

#Disconnect-PowerBIServiceAccount
$sp = Connect-PowerBIServiceAccount -Environment Public -ServicePrincipal  -Credential $credential -Tenant $tenantId

$AppId = $sp.UserName

Write-Host
Write-Host "Logged on as service principal with AppID of $AppId"
Write-Host

