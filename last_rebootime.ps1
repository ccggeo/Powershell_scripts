
$machines = Get-ADComputer -searchbase "***" -filter * -Properties name, description 

$computers = $machines.name


$output =@()

foreach ($comp in $computers){
    
    $line = '' | select comp, lastboot, user
    $description = (invoke-command -computername $comp -scriptblock {Get-ADComputer $comp -filter * -Properties description }).description
    $state = invoke-command -computername $comp -scriptblock {Get-WmiObject win32_operatingsystem | select csname, @{LABEL=’LastBootUpTime’;EXPRESSION={$_.ConverttoDateTime($_.lastbootuptime)}}
    

                                                             }
   
        $line.comp = $comp
        $line.lastboot = $state.lastbootuptime
        $line.user = $description


        $output += $line
                            }

$output | Out-GridView 



<#
 $timestamp = $(get-date -Format ddMMyyyy)
$output | export-csv C:\temp\lastreboot_$timestamp.csv

Invoke-Expression C:\temp\lastreboot_$timestamp.csv#>