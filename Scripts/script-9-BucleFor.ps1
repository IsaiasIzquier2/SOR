

param($v1, $v2)

$list = Import-Csv -Path .\datos.csv -Delimiter ";"

for ($i = $v1; $i -le $v2; $i++) {
    
    Write-Host "$($list[$i].nombre)  $($list[$i].primer_apellido)  $($list[$i].segundo_apellido)"

}


