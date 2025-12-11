# Busca el servicio de la cola de impresión

param ($dn)

get-service -DisplayName *$dn*

