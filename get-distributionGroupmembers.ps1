$x = (get-distributiongroup -OrganizationalUnit "").primarysmtpaddress
$output= @()


$x | %{
$line = '' | select distributiongroup, members 

$y = (Get-DistributionGroupMember $_).name


#$c = [string]$y

$line.distributiongroup = $_
$line.members = $y -join ', '

$line
$output += $line 


}
$output | export-csv c:\temp\DG_members.csv







$DG = (import-csv c:\temp\DG_members.csv).distributiongroup

$DG | % {

if ($_ -eqif ($x -gt $y)
{
    
} $y)
{
    
}



}



$DG.distributiongroup 





