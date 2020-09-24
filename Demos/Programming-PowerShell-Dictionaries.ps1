$outputFilePath = "$PSScriptRoot/Pets.txt"

$pets = @(
  @{ Name="Bob"; Type="Cat" }
  @{ Name="Diggity"; Type="Dog" }
  @{ Name="Larry"; Type="Lizard" }
  @{ Name="Penny"; Type="Porcupine" }
)

"My Pets" | Out-File $outputFilePath

foreach($pet in $pets) {
  $name = $pet.Name
  $type = $pet.Type
  " - $name the $type" | Out-File $outputFilePath -Append
}

notepad.exe $outputFilePath

