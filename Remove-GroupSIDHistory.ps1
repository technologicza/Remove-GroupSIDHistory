## created by Jean Louw and Chris Bishop
## Please note that you run this code at your own risk

$GroupOU = 'OU=ouname,DC=domain,DC=com'
$AllGroups = Get-ADGroup -SearchBase $GroupOU -Filter *


foreach ($Group in $AllGroups){

$GroupValue = $Group.Name

$SIDValue = (Get-ADGroup -Identity $GroupValue -Properties SidHistory | Select-Object -ExpandProperty SIDHistory).Value

if ($SIDValue -ne $null){
Write-Host "..removing" $SIDValue "from" $GroupValue -ForegroundColor Red
#Set-ADGroup -Identity $GroupValue -Remove @{SIDHistory=$SIDValue}
}

else{
Write-Host "..skipping" $GroupValue "as it has no SIDHistory" -ForegroundColor Green
}

Remove-Variable GroupValue
Remove-Variable SIDValue
}
