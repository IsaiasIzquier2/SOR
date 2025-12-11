param ($csv, $contrasenaTemporal)


$tesla = Import-Csv -Path $csv -Delimiter ";"




for ($row = 0; $row -lt $tesla.Count; $row++) {


    if (Get-ADOrganizationalUnit -Filter "Name -eq '$($tesla[$row].departamento)' ")
    {
        $existe = "Existe"
    }
    else
    {
        New-ADDOrganizationalUnit -Name "$($tesla[$row].departamento)" -ProtectedFromAcccidentalDeletion $false
    }

    

    $login = $($tesla[$row].dni[0..3] -join "") + $($tesla[$row].apellido1[-1..3] -join "")
    
    if ($tesla[$row].activo -eq "on") {
        $enabled = $true
        
    }
    else {
        $enabled = $false
    }

    $ou = "OU=$($tesla[$row].departamento),DC=isaias,DC=local"

    if (Get-ADUser -Filter "SameAccountName -eq '$login'") {
        
    }

    else {
        
        New-ADUser `
        -Name "$($tesla[$row].nombre) $($tesla[$row].apellido2) $($tesla[$row].apellido2)" `
        -GivenName "$($tesla[$row].nombre)" `
        -Surname "$($tesla[$row].apellido2) $($tesla[$row].apellido2)" `
        -SamAccountName "$login" `
        -UserPrincipalName "$login@tesla.com" `
        -Enabled $enabled `
        -Path "$ou" `
        -AccountPassword (ConvertTo-SecureString $contrasenaTemporal -AsPlainText -Force) `
        -ChangePasswordAtLogon $true
    }
    
}
