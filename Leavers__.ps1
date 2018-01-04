# RUN BEFORE THEY LEAVE
<#
.Synopsis
   Functions to delete staff from systems and inform appropriate staff
.EXAMPLE
   removebsuser -username -emailstaff $TRUE
#>

function predeparture 
    {

        [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        $emailstaff
    )
    if ($emailstaff -eq $TRUE)
    {
        

}
else {write-host "staff not emailed pre-depature requirements" -ForegroundColor Cyan
   
    }}

function remove-user{

    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        $username,
        [Parameter(Mandatory=$false)]
        $target_computer,
        [Parameter(Mandatory=$true)]
        $emailstaff
    )
        $user = get-aduser $username -Properties * 
        $new_user_name = $user.name 
        $new_user_email = $user.mail
        $new_user_username = $user.mailNickname
        $new_user_first_name = $user.GivenName
        $manager = $user.manager 
        $managerobj = get-aduser $manager -Properties *
        $manager_mail = $managerobj.mail
        $date = get-date -uformat "%Y%m%d"
    
begin 
    {



    }

process{

#global variables
Import-Module ActiveDirectory
import-module <exchange>

#After they leave
#hide address in exchange 
Set-Mailbox $new_user_email -HiddenFromAddressListsEnabled $true


# remove name from associated computer
#function to remove name from all associated computers in AD
$dec_ = $new_user_name
$leaver_computer = (get-adcomputer -Properties * -filter * | Where-Object {$_.description  -like "*$dec_*"}).name
$leaver_computer | %{

Set-ADComputer $_  -description ' '}



#Remove user from all associated ACL groups/distribution lists 
$group_membership = Get-ADPrincipalGroupMembership $username
$x = $group_membership
$x | % {
Remove-ADGroupMember  $_  $username -Confirm:$false
}


#remove all active-sync devices associated with user account 
try{
    $devices = Get-MobileDevice -mailbox $_ -ErrorAction 
    $deviceid = $devices.id
    $deviceid | % {
    remove-activesyncdevice -Identity $_
    Write-host "All associated active sync devices removed from leaver account" -ForegroundColor Green
    }
    
}
catch {
write-host "No active-sync pairings found" -BackgroundColor red 
}

#Remove user from Freshservice 

$APIKey = ''
$EncodedCredentials = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $APIKey,$null)))
$HTTPHeaders = @{}
$HTTPHeaders.Add('Authorization', ("Basic {0}" -f $EncodedCredentials))
$HTTPHeaders.Add('Content-Type', 'application/json')


$URL = ''
$users = Invoke-RestMethod -Method Get -Uri $URL -Headers $HTTPHeaders 
$data = $users.user
$data | select name, id

$userdata = $data | Where-Object {$_.name -like "*$new_user_name*"} 

if ($userdata.name -ne $null){
$user_id = $userdata.id 
Invoke-RestMethod -Method delete -uri "$URL/$user_id.json"-Headers $HTTPHeaders 
}

else{


$users = Invoke-RestMethod -Method Get -Uri $URL -Headers $HTTPHeaders 

$data = $users.user
$data | select name, id

$userdata = $data | Where-Object {$_.name -like "*$new_user_name*"} 
$user_id = $userdata.id 

Invoke-RestMethod -Method delete -uri "$URL/$user_id.json" -Headers $HTTPHeaders 

}


if ($emailstaff -eq $TRUE)
{


else
{
write-host "Staff NOT emailed SOP confirmations" -ForegroundColor cyan 
    
}


# disable user account, remove manager and set description as date disabled 
set-aduser -identity $username -Enabled $false -Manager $null -Description $date
 
# move to disabled users OU
get-aduser $username | move-ADObject -TargetPath "OU=Disabled Users,DC=blacksun,DC=com"
        
        }


    End
    {
            # Report
            Write-Host "$new_user_name has been removed "
 
 
  }}
  }

#preflight
#predepature -emailstaff $TRUE
                                                                                  
remove-user 


