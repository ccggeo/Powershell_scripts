


$computers = Get-ADComputer  -searchbase '***' -filter * -Properties * 

$computers.name 


$output =@()
   

foreach ($comp in $computers){
    
    $line = '' | select comp, state 

     invoke-command -computername $comp -scriptblock {
    
    $smb1 = (Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters).smb1
                              

                              if ($smb1 =1){ $state = 'Enabled'}
                              
                              else {$state= 'Disabled'}
                             


                                                             }
        
        $line.comp = $comp
        $line.state = $state.state
         
        $output += $line
                            }

#$output | Out-GridView 

 

 $timestamp = $(get-date -Format ddMMyyyy)
$output | export-csv C:\temp\smb1_$timestamp.csv

#Invoke-Expression C:\temp\$timestamp.csv