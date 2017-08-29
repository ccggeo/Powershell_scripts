
$computers = ''

$output= @()

$computers | % {

$line = '' | select hostname, Ctotal, Cfree, Cused, Dtotal, Dfree, Dused, user

$Ctotal = Get-CimInstance -ComputerName $_ win32_logicaldisk | where caption -eq "C:" | foreach-object {write " $('{0:N2}' -f ($_.Size/1gb))"}
$cfree = Get-CimInstance -ComputerName $_ win32_logicaldisk | where caption -eq "C:" | foreach-object {write "$('{0:N2}' -f ($_.FreeSpace/1gb)) "}

#calculate used space on c drive
$cused = $ctotal - $cfree


$D = Get-CimInstance -ComputerName $_ win32_logicaldisk | where caption -eq "D:" | foreach-object {write " $($_.caption) $('{0:N2}' -f ($_.Size/1gb)) , $('{0:N2}' -f ($_.FreeSpace/1gb))  "}

$dtotal = Get-CimInstance -ComputerName $_ win32_logicaldisk | where caption -eq "D:" | foreach-object {write " $('{0:N2}' -f ($_.Size/1gb))"}
$dfree = Get-CimInstance -ComputerName $_ win32_logicaldisk | where caption -eq "D:" | foreach-object {write "$('{0:N2}' -f ($_.FreeSpace/1gb)) "}
#calculate used space on d drive
$dused = $dtotal - $dfree


$line.hostname = $_
$line.Ctotal = $Ctotal
$line.Cfree = $Cfree
$line.Cused = $cused

$line.dtotal = $dtotal
$line.dfree = $dfree
$line.dused = $dused




$line.D = $D
$line.user = (get-adcomputer $_).description 

write-host "processing" $_ -BackgroundColor Green
 
 
 $output += $line 



    }

$output | Out-GridView