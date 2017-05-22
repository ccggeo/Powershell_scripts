#Grabs workstations dependant on naming scheme 
$name = Get-ADComputer -filter * | ? { $_.Name -like "*name*" }  

$output =@()

$name | % {
$line = '' | select comp, smb1status 

    invoke-command -ComputerName $_ -ScriptBlock{

    $smb1enabled = (Get-WindowsOptionalFeature -online | Where-Object {$_.FeatureName -eq "smb1protocol"}).state
    
 
}

   $line.comp = $_.name
    $line.smb1status = $smb1enabled
     

     $output += $line


}

$output | Out-GridView 



    