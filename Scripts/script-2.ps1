# En un mismo script busca el servicio de cola de impresión y páralo

param ($dn)

$servSearch = get-service -DisplayName *$dn*

$ns = $servSearch[2].Name

Stop-Service -Name  $ns