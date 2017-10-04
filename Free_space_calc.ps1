#all figures in GB


$computers = 
$output= @()

$computers | % {

$line = '' | select hostname, Ctotal, Cfree, Cused, Dtotal, Dfree, Dused, user

$Ctotal = Get-CimInstance -ComputerName $_ win32_logicaldisk | where caption -eq "C:" | foreach-object {write " $('{0:N2}' -f ($_.Size/1gb))"}
$cfree = Get-CimInstance -ComputerName $_ win32_logicaldisk | where caption -eq "C:" | foreach-object {write "$('{0:N2}' -f ($_.FreeSpace/1gb)) "}

#calculate used space on c drive
$cused = $ctotal - $cfree

$user_name = get-adcomputer $_ -Properties *
$user_name2 = $user_name.description
$line.user = $user_name2



$d_exist = test-path \\$_\d$
if ($d_exist -eq $TRUE)
{

$D = Get-CimInstance -ComputerName $_ win32_logicaldisk | where caption -eq "D:" | foreach-object {write " $($_.caption) $('{0:N2}' -f ($_.Size/1gb)) , $('{0:N2}' -f ($_.FreeSpace/1gb))  "} -ErrorAction Stop 

$dtotal = Get-CimInstance -ComputerName $_ win32_logicaldisk | where caption -eq "D:" | foreach-object {write " $('{0:N2}' -f ($_.Size/1gb))"}
$dfree = Get-CimInstance -ComputerName $_ win32_logicaldisk | where caption -eq "D:" | foreach-object {write "$('{0:N2}' -f ($_.FreeSpace/1gb)) "}
#calculate used space on d drive
$dused = $dtotal - $dfree


$line.dtotal = $dtotal
$line.dfree = $dfree
$line.dused = $dused

    
}



else{
$line.dtotal = 'n/a'
$line.dfree = 'n/a'
$line.dused = 'n/a'}

$line.hostname = $_
$line.Ctotal = $Ctotal
$line.Cfree = $Cfree
$line.Cused = $cused


$line.D = $D

write-host "processing" $_ -BackgroundColor Green
 
 
 $output += $line 



    }

$output | export-csv c:\temp\_HDD.csv

Invoke-Expression c:\temp\_HDD.csv