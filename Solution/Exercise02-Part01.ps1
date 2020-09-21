
$user = Connect-PowerBIServiceAccount

$userName = $user.UserName

Write-Host
Write-Host "Now logged in as $userName"