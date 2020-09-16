Clear-Host

$pets = @(
  @{ Name="Bob"; Type="Cat" }
  @{ Name="Diggity"; Type="Dog" }
  @{ Name="Larry"; Type="Lizard" }
  @{ Name="Penny"; Type="Porcupine" }
)

Write-Host 
Write-Host "My Pets"

foreach($pet in $pets) {
  $name = $pet.Name
  $type = $pet.Type
  Write-Host " - $name the $type"
}

Write-Host