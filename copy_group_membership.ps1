Import-Module ActiveDirectory


$user_copy = read-host -Prompt "input old user to copy membership from"
$new_user = read-host -Prompt "input new User to copy membership to"

$group_membership = Get-ADPrincipalGroupMembership $user_copy | select name 



$group_membership | % { 

add-adgroupmember -identity $_.name -members $new_user


}


