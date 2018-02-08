$server  = "bs-fp-ex-mb3.blacksun.com"


#By Sender
$sender = ""
get-messagetrackinglog  -Server $server -Sender $sender -Start (Get-Date).AddDays(-7) -End (Get-Date) -ResultSize 9999999 -Verbose | select Timestamp, MessageSubject, Sender, Recipients, Totalbytes | Sort-Object -Property Timestamp 
 
#By Recipient
 
$recipient = ""
 
get-messagetrackinglog -recipient $recipient -Server $server   -Start (Get-Date).Adddays(-1) -End (Get-Date) -ResultSize 9999999 -Verbose | select Timestamp, MessageSubject, Sender, Recipients, Totalbytes | sort-object -property Timestamp 
 
 
# By recipient and sender
 
$recipient = ""
$sender = ""
 
 
get-messagetrackinglog -recipient $recipient -Sender $sender -Server $server  -Start (Get-Date).AddDays(-2) -End (Get-Date) -ResultSize 9999999 -Verbose

