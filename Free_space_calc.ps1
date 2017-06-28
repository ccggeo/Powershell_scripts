
$computers = 

$output= @()

$computers | % {

$line = '' | select hostname, C, D, user

$C = Get-CimInstance -ComputerName $_ win32_logicaldisk | where caption -eq "C:" | foreach-object {write " $($_.caption) $('{0:N2}' -f ($_.Size/1gb)) GB total, $('{0:N2}' -f ($_.FreeSpace/1gb)) GB free "}
$D = Get-CimInstance -ComputerName $_ win32_logicaldisk | where caption -eq "D:" | foreach-object {write " $($_.caption) $('{0:N2}' -f ($_.Size/1gb)) GB total, $('{0:N2}' -f ($_.FreeSpace/1gb)) GB free "}

$line.hostname = $_
$line.C = $C
$line.D = $D
$line.user = (get-adcomputer $_).description 

write-host "processing" $_ 
 
 
 $output += $line 



    }

$output | Out-GridView