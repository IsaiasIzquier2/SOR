param ($csv, $contrasenaTemporal)


$tesla = Import-Csv -Path $csv -Delimiter ";"




for ($row = 0; $row -lt $tesla.Count; $row++) {


    if (Get-ADOrganizationalUnit -Filter "Name -eq '$($tesla[$row].departamento)' ")
    {
        $existe = "Existe"
    }
    else
    {
        New-ADOrganizationalUnit -Name "$($tesla[$row].departamento)" -ProtectedFromAccidentalDeletion $false
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
    if (Get-ADgroup -Filter "Name -eq 'producto' "){
        
            Write-Host "producto existe"
        }
        else
        {
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
    
        if ( ([int]$tesla[$row].experiencia) -lt 1 ) {
    
            Add-ADGroupMember -Identity "novel" -Members $login
            
        }

        if ( ($tesla[$row].departamento) -eq "Produccion" ) {
    
            Add-ADGroupMember -Identity "produccion" -Members $login
            
        }
        else {
            Add-ADGroupMember -Identity "oficina" -Members $login
        }
}


