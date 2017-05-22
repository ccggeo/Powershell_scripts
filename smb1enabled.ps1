#Grabs workstations dependant on naming scheme 
$name = Get-ADComputer -filter * | ? { $_.Name -like "*name*" } 
$computers =@()

$name | % {

   $computers += $_.name

}


$output =@()
   


foreach ($comp in $computers){
$line = '' | select comp, state 

$state = invoke-command -computername $comp -scriptblock {(Get-WindowsOptionalFeature -online | Where-Object {$_.FeatureName -eq "smb1protocol"})


$smb1enabled = $state.state 

$smb1enabled}


$line.comp = $comp
$line.state = $state.state 
     $output += $line
 }
 

 
$output | Out-GridView 
