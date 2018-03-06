$x =""

$output= @()

$x | % {
$o = Get-distributiongroup $_ 
if($o -ne $null){write-host $_ }
   else{  
    $_ 
   }


$y = New-Object PSCustomObject 
$y | add-member -MemberType NoteProperty -Name "Primarysmtpaddress" -Value $_
$exists = if($o.Primarysmtpaddress -ne $Null){echo "Exists"} else{echo "Doesnt exist"}
$y |  add-member -MemberType NoteProperty -Name "exists" -Value $exists
$output += $y

    }

$output |FT

<#
$y = New-Object PSCustomObject 
$y = -Property([ordered] @{"Name" = $o.Name
"Primarysmtpaddress" = $o.Primarysmtpaddress
"exists" = if($o.Primarysmtpaddress -ne $Null){echo "Exists"}
           else{echo "Doesnt exist"}#>


#$o | select-object Name, Primarysmtpaddress, @{Name="exists"; Expression={$_}}



