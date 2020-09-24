
# log into Azure AD as service principal
$tenantId = "e60e3ff3-1c14-4f63-aca4-d30475c0a3d1"
$applictionId = "50b0f8ac-0b31-4098-a139-48e339148b41"
$applicationSecret = "PY3VlZs.2_G65mui227~Xm_5-5X41~02ic"

$secureApplicationSecret = ConvertTo-SecureString -String $applicationSecret -AsPlainText -Force

Connect-DataGatewayServiceAccount -ApplicationId $applictionId -ClientSecret $secureApplicationSecret -Tenant $tenantId



