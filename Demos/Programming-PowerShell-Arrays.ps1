Clear-Host

$hobbies = @("Pilates", "Kick boxing", "Power BI Embedding")

Write-Host 
Write-Host "My Hobbies"

foreach($hobby in $hobbies) {
  Write-Host " - $hobby"
}

Write-Host
