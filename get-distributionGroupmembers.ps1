$x = (get-distributiongroup ).primarysmtpaddress
$output= @()


$x | %  {
$line = '' | select distributiongroup, members 

$y = (Get-DistributionGroupMember $_).name


$c = ($y | out-string).Trim()



#$c = [string]$y

$line.distributiongroup = $_
$line.members = $c

$line
$output += $line 


}
$output | export-csv c:\temp\DG_members.csv



