param($csv)

$apple = Import-Csv -Path $csv -Delimiter ";"

for ($row = 0; $row -lt $apple.Count; $row++) {
    
    if (Get-ADOrganizationalUnit -Filter "Name -eq '$($apple[$row].departament)'") {
    }

    else {
        New-ADOrganizationalUnit -Name "$($apple[$row].departament)" -ProtectedFromAccidentalDeletion $false
    }
}