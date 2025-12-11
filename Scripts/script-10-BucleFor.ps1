param ($varGrupo)

$list = Import-Csv -Path .\datos.csv -Delimiter ";"

$count = 0

for ($i = 0; $i -lt $list.Count; $i++) {
    
    if ($list[$i].grupo -eq $varGrupo) {

        $count = $count+1
    }

}

Write-Host " Hay $count personas en el grupo $varGrupo"
