$computers= Get-ADComputer -SearchBase "OU=Windows,OU=Black Sun Workstations,DC=blacksun,DC=com" -Filter {enabled -eq $true} 
 
$output= @()
$computers| % {
    
    $line= '' | Select DNSHostname,UpdateStatus
     Invoke-Command -ComputerName $_.DNSHostname -ScriptBlock { Get-Service wuauserv | ? {$_.status –eq 'Stopped'} | Start-Service}


$line.DNSHostname = $_.DNSHostname
$line.updatestatus = Invoke-Command -ComputerName $_.DNSHostname -ScriptBlock { (get-service wuauserv).status}
  $line
  $output +=$line
             }
                   

 
$timestamp = $(get-date -Format HHmmddMMyyyy)
$output | export-csv C:\Users\cgeorge\Documents\WSUS\post-service-$timestamp.csv