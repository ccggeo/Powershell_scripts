#Grabs workstations dependant on naming scheme 
$name = Get-ADComputer -filter * | ? { $_.Name -like "*name*" }  

$name.name 


$name | % {

invoke-command -ComputerName $_.name -ScriptBlock{

$smb1enabled = (Get-WindowsOptionalFeature -online | Where-Object {$_.FeatureName -eq "smb1protocol"}).state
 
$smb1enabled
}

}