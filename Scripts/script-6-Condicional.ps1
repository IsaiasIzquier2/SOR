$row = Read-Host "Introduce num de columna"

$persona = Import-Csv -Path .\datos.csv -Delimiter ";"

if ($persona[$row].grupo -ge "profesor" ){

    Write-Host "profesor"
}
else {
    
}

