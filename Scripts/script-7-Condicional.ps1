
$row = Read-Host "Introduce num de columna:"

$persona = Import-Csv -Path .\datos.csv -Delimiter ";"

if ($persona[$row].edad -ge 18){

    $edad = "mayor"
}
else {
    $edad = "menor"
}

Write-Host "$edad de edad"