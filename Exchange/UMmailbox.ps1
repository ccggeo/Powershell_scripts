#if everything in disabled OU set UMMailbox 

$usernames = (get-aduser -searchbase "" -Properties * -filter *).mailnickname 


$usernames | %{

$uMenabled = Get-UMMailbox $_



if ($umenabled.umenabled  -eq "True")
{
 Disable-UMMailbox $_ 
 write-host "$_ UMMailbox disabled"  -ForegroundColor green
}
else{
write-host "$_ UMMailbox not enabled" -ForegroundColor red
}


}}



