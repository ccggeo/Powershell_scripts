$dg = 

$emails = @()

$members = (Get-DistributionGroupMember  debeers).Name
$members | % {

    $member = $_ 

    $email = (get-aduser  -Properties * -filter * | ? {$_.name  -like "*$member*"}).emailaddress

    $emails += $email 
    $emails.count
}



$dg | %{
New-DistributionGroup $_ -members 
 
}