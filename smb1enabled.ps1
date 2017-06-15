#Grabs workstations dependant on naming scheme 
$computers =@()


$name = Get-ADComputer -filter * | ? { $_.Name -like "*DW*"  } 



$name | % {
   $computers += $_.name
}

$name = Get-ADComputer -filter * | ? { $_.Name -like "*VW*"  } 



$name | % {
   $computers += $_.name
}

$name = Get-ADComputer -filter * | ? { $_.Name -like "*LW*"  } 



$name | % {
   $computers += $_.name
}

$name = Get-ADComputer -filter * | ? { $_.Name -like "*TW*"  } 

$name | % {
   $computers += $_.name
}

$computers


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