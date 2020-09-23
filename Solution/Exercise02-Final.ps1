# log into Azure AD user account with hard-code user name and password
$userName = "user1@tenant1.onMicrosoft.com"
$password = "myCat$rightLeg"

# convert password to secure string
$securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force

# create PSCredential object to serve as login credentials
$credential = New-Object -TypeName System.Management.Automation.PSCredential `
                         -ArgumentList $userName, $securePassword

# log into Power BI unattended without any user interaction

$user = Connect-PowerBIServiceAccount $credential

Get-PowerBIWorkspace | Format-Table Name, Id