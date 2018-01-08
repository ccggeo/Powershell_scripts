#if everything in disabled OU set UMMailbox 


$usernames = (get-aduser -searchbase "" -Properties * -filter *).mailnickname 


$usernames | %{

$uMenabled = Get-UMMailbox $_

$umenabled.umenabled 

} 
