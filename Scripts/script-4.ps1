# Crea un script que reciba el nombre de un servicio, que pare el servicio, espere unos segundos y vuelva a iniciarlo
param ($dn)

""

$dn = Read-Host "Busca por:"

$servSearch = get-service -DisplayName *$dn*

$servSearch

""

$row = Read-Host "Seleciona una fila de la 1 a la "$servSearch.Count

""

Write-Host "Fila selecionada $row"

$ns = $servSearch[$row-1].Name

""

Write-Host "Servicio selecionado: $ns"

Stop-Service $ns


get-service -DisplayName *$dn*

Start-Sleep -Seconds 5

Start-Service $ns

get-service -DisplayName *$dn*

