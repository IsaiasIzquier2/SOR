param ($csv, $contrasenaTemporal)


$tesla = Import-Csv -Path $csv -Delimiter ";"

 
# Recorre todas las del csv, es como "for i in tesla", for(inicialización, condición, incremento)
for ($row = 0; $row -lt $tesla.Count; $row++) {

    #El get lista todas las OU existen y compara si alguna tiene el nombre de algunos de los departamentos del csv
    if (Get-ADOrganizationalUnit -Filter "Name -eq '$($tesla[$row].departamento)' ")
    {

    }
    # En en caso de que no, se crea una nueva con cada nombre en la comlumna departamento del csv
    else
    {                                                                 #Quita protección contra borrado
        New-ADOrganizationalUnit -Name "$($tesla[$row].departamento)" -ProtectedFromAccidentalDeletion $false
    }

    
    # De cada columna recoge esos valores para crear el login
    $login = $($tesla[$row].dni[0..3] -join "") + $($tesla[$row].apellido1[-1..3] -join "")
    
    # Comprueba en la columna activo y almacena en variable enabled
    if ($tesla[$row].activo -eq "on") {
        $enabled = $true
        
    }
    else {
        $enabled = $false
    }

    # ? 5/5
    $ou = "OU=$($tesla[$row].departamento),DC=isaias,DC=local"

    # Get lista todos los usuarios y los compara con el login 
    if (Get-ADUser -Filter "SameAccountName -eq '$login'") {
        
    }

    # Si no existe se crea
    else {
        
        New-ADUser `
        -Name "$($tesla[$row].dni) " `
        -GivenName "$($tesla[$row].nombre)" `
        -Surname "$($tesla[$row].apellido2) $($tesla[$row].apellido2)" `
        -SamAccountName $login `
        -UserPrincipalName $login@tesla.com `
        -Enabled $enabled `
        -Path $ou `
        -AccountPassword (ConvertTo-SecureString $contrasenaTemporal -AsPlainText -Force) `
        -ChangePasswordAtLogon $true

    }

    #Conprueba si el grupo producto existe, si no existe lo crea
    if (Get-ADgroup -Filter "Name -eq 'producto' "){
        
            Write-Host "producto existe"
        }
        else
        {                                 
                                        #GroupScope acceso a todo el dominio o solo ciertas UO  
                                        #GroupCategory 
                                        # Security gestionar permisos y recursos
                                        # Distriburtoin lista de distribución de correo

            New-ADgroup -Name "producto" -GroupScope Global -GroupCategory Security
            
        }
    
    if (Get-ADgroup -Filter "Name -eq 'oficina' "){
        
            Write-Host "oficina existe"
        }
        else
        {
            New-ADgroup -Name "oficina" -GroupScope Global -GroupCategory Security
        }
    
    if (Get-ADgroup -Filter "Name -eq 'novel' "){
        
            Write-Host "novel existe"
        }
        else
        {
            New-ADgroup -Name "novel" -GroupScope Global -GroupCategory Security
        }    
    


        #Si esta en departamento producción lo mete al grupo producción
        if ( ($tesla[$row].departamento) -eq "Produccion" ) {
            
            Add-ADGroupMember -Identity "produccion" -Members $login
            
        }

        #Y si no pa el de oficina
        else {
            Add-ADGroupMember -Identity "oficina" -Members $login
        }

        #Y si tiene menos de un año de experiencia pa el novel
        if ( ($tesla[$row].experiencia) -lt 1 ) {
    
            Add-ADGroupMember -Identity "novel" -Members $login
            
        }
    }
    
    if (condition) {
        <# Action to perform if the condition is true #>
    }


