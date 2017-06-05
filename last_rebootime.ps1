$machines=@()

$name = Get-ADComputer -filter * | ? { $_.Name -like "**"  } 


$machines

$output =@()

foreach ($comp in $machines){
    
    $line = '' | select comp, lastboot 

    $state = invoke-command -computername $comp -scriptblock {Get-WmiObject win32_operatingsystem | select csname, @{LABEL=’LastBootUpTime’;EXPRESSION={$_.ConverttoDateTime($_.lastbootuptime)}}
                                                             }
        
        $line.comp = $comp
        $line.lastboot = $state.lastbootuptime
         
        $output += $line
                            }

$output | Out-GridView 

