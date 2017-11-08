#global variables
Import-Module ActiveDirectory
import-module <exchange>
$username = read-host 'Enter username of leaver'
$user = get-aduser $username -Properties * 
$target_computer = read-host -Prompt "Input Computer name"
$new_user_name = $user.name 
$new_user_email = $user.mail
$new_user_username = $user.mailNickname
$new_user_first_name = $user.GivenName
$manager = $user.manager 
$managerobj = get-aduser $manager -Properties *
$manager_mail = $managerobj.mail

#1. disable user account
set-aduser -identity $username -Enabled $false
#2. move to disabled users OU
get-aduser $username | move-ADObject -TargetPath <ADSI of OU>
#3. remove name from associated computer
Set-ADComputer $target_computer -Description ' '


#4. hide address in exchange 
Set-MailContact $new_user_email -HiddenFromAddressListsEnabled $true

#5. Remove user from all associated ACL groups/distribution lists 
$group_membership = Get-ADPrincipalGroupMembership $username
$x = $group_membership
$x | % {
Remove-ADGroupMember  $_  $username -Confirm:$false
}

#6. remove all active-sync devices associated with user account 
try{
    $devices = Get-MobileDevice -mailbox $new_user_username -ErrorAction 
    $deviceid = $devices.deviceId
    $deviceid | % {
    remove-activesyncdevice -Identity $_
    }
    Write-host "All associated active sync devices removed from leaver account" -ForegroundColor Green

}
catch {
write-host "No active-sync pairings found" -BackgroundColor red 
}



#7. Remove user from Freshservice API
$K = ''
$EncodedCredentials = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $K,$null)))
$HTTPHeaders = @{}
$HTTPHeaders.Add('Authorization', ("Basic {0}" -f $EncodedCredentials))
$HTTPHeaders.Add('Content-Type', 'application/json')


$URL = 'itil/requesters.json'
$users = Invoke-RestMethod -Method Get -Uri $URL -Headers $HTTPHeaders 
$data = $users.user
$data | select name, id

$userdata = $data | Where-Object {$_.name -like "*$new_user_name*"} 
if ($userdata.name -ne $null){
$user_id = $userdata.id 
Invoke-RestMethod -Method delete -uri /itil/requesters/$user_id.json -Headers $HTTPHeaders 
}

else{


$URL = 'itil/requesters.json?page=2'
$users = Invoke-RestMethod -Method Get -Uri $URL -Headers $HTTPHeaders 

$data = $users.user
$data | select name, id

$userdata = $data | Where-Object {$_.name -like "*$new_user_name*"} 
$user_id = $userdata.id 

Invoke-RestMethod -Method delete -uri /itil/requesters/$user_id.json -Headers $HTTPHeaders 

}
