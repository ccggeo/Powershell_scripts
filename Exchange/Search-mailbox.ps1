$searchmail = #Inbox to search for 
$ownmailbox = #your own mailbox 
$target = #Target mail

Search-Mailbox -SearchQuery "from:$searchmail" -TargetMailbox $ownmailbox -TargetFolder "Drafts" -LogLevel Full -Verbose -Identity $target