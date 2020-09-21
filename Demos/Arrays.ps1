

$numbers = 1..3

foreach($number in $numbers) {

    Write-Host $number
    Start-Sleep -Seconds 1

}

$letterArray = "a","b","c","d"

foreach($letter in $letterArray) {
  Write-Host $letter
}

Function Add-Numbers($one, $two) {
    $one + $two
}