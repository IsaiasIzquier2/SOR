$row = Read-Host "Introduce num de columna"
$grp = Read-Host "Introduce el grupo de esa fila:"

$persona = Import-Csv -Path .\datos.csv -Delimiter ";"

if ($persona[$row].grupo -ge $grp  ){

    $edad = "Correcno, si"
}
else {
    $edad = "Incorrecto, no"
}

Write-Host "$edad pertenece a ese grupo"