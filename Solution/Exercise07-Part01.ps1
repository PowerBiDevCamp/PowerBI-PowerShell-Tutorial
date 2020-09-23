
Connect-PowerBIServiceAccount | Out-Null

Get-PowerBIWorkspace -Scope Organization -Filter "state eq 'Active'" | Format-Table Name, Type, Id