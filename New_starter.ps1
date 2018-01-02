Import-Module ActiveDirectory
Add-Type -AssemblyName System.Web
import-module <exchange>

$first_name = read-host -Prompt "Input new starter First Name"
$surname = read-host -Prompt "Input new starter Last Name"
$username = read-host -Prompt "Input new starter username"
$displayName = $first_name + " " + $surname
$firstChar = $first_name.substring(0,1)
$user_email =  $firstChar + $surname + "@consoto"

$pass = "Ub=5#Zhg"
$secure_string_email = ConvertTo-SecureString -AsPlainText $pass -force

new-mailbox -UserPrincipalName $user_email -Password $secure_string_email -Name $displayName -FirstName $first_name -LastName $surname -DisplayName $displayName -OrganizationalUnit <OU>

$user = get-aduser $username -Properties *
$target_computer = read-host -Prompt "Input Computer name"
$title = read-host -Prompt "Input Title of new user" 
$department = read-host -Prompt "Input Department of new user" 
$new_user_name = $user.name 
$new_user_email = $user.mail
$new_user_username = $user.mailNickname
$new_user_first_name = $user.GivenName
$manager_input = read-host -Prompt "Input manager username"
$manager = get-aduser $manager_input -Properties *
$manager_email = $manager.mail
$calendar_user = $new_user_email + ":\calendar"

#fill user properties
set-aduser -Identity $new_user_username  -Description $title  -manager $manager -title $title -Department $department
#set default mailbox permission to Reviewer 
Set-MailboxFolderPermission -Identity $calendar_user -User Default -AccessRights Reviewer


$user_copy = read-host -Prompt "input old user to copy membership from"

$group_membership = Get-ADPrincipalGroupMembership $user_copy | select name 

$group_membership | % { 

add-adgroupmember -identity $_.name -members $user 

}

$group_membership2= Get-ADPrincipalGroupMembership $new_user_username | select name 
$group_membership2


#Set password
$NonAlphCh = [System.Web.Security.Membership]::GeneratePassword(8,0) 
$NonAlphCh 

#SFB phone. Separate script
$SFBphone = get-content C:\scripts\$new_user_username"_number".txt

set-aduser -Identity $new_user_username -officephone $SFBphone

get-aduser $new_user_username -Properties * | select officephone

write-host "
            $new_user_username details:   
                      
            Email: $new_user_email

            Logon Username: $new_user_username

            Password: $NonAlphCh 

            Number: $SFBphone" -foregroundcolor green


Send-MailMessage  


#creates the signature locally 
function create-signature {

param($adusername)

$user = get-aduser -Properties * -filter * | Where-Object {$_.mailnickname  -like "*$adusername*"}

$name = $user.name 
$title = $user.title 
$sfbphone = $user.telephonenumber
$username = $user.mailnickname 
$local_username = ""
$Signature = Get-Content C:\Users\$local_username\Desktop\Signature_creator\signature_template_.txt

write-host "Creating $name signature" -BackgroundColor blue

#template in HTML with placeholders
(Get-Content C:\Users\$local_username\Desktop\Signature_creator\Signature_template_.txt).replace('$name', $name) | Set-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\v1.txt
(Get-Content  C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\v1.txt).replace('$title', $title) | Set-Content  C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\v2.txt
(Get-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\v2.txt).replace('$phone', $sfbphone) | Set-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\v3.txt
(Get-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\v3.txt).replace('$username', $username) | Set-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\final.htm

Get-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\v3.txt | Set-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\final_text.txt
Get-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\v3.txt | Set-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\final_rtf.rtf
invoke-expression C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\final.htm
}

create-signature -adusername $new_user_username  




##Add user to Freshservice 
$APIKey = ''
$EncodedCredentials = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $APIKey,$null)))
$HTTPHeaders = @{}
$HTTPHeaders.Add('Authorization', ("Basic {0}" -f $EncodedCredentials))
$HTTPHeaders.Add('Content-Type', 'application/json')
$URL = <URL>

$UserAttributes = @{}
$UserAttributes.Add('name', $new_user_name)
$UserAttributes.Add('email' , $new_user_email)
$UserAttributes.Add('phone' , $SFBphone)
$UserAttributes.Add('Title' , $title)
$UserAttributes.Add('reporting manager' , $manager.name)

$UserAttributes = @{'user' = $UserAttributes}
$JSON = $UserAttributes | ConvertTo-Json 

Invoke-restmethod -Method POST -Uri $URL -Headers $HTTPHeaders -Body $JSON


Set-ADComputer $target_computer -Description $name
