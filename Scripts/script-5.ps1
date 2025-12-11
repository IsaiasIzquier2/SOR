
$datos = Import-Csv -Path .\datos.csv -Delimiter ";"

$datos[138]

""

$datos[197].nombre

""
$datos2 = "$($datos[109].primer_apellido) $($datos[109].segundo_apellido)"

$datos2
""

$datos[31].grupo

""

$datos[67].edad


