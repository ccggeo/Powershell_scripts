#edit these variables to change values of signature
$prompt1 = read-host -Prompt "Input username"
$prompt2 = read-host -Prompt "Confirm username"

if ($prompt2 -eq $prompt1)


{$target_computer = read-host -Prompt "Input old computer name"
$extension = read-host -Prompt "Input Extension"
$new_computer = read-host -Prompt "Input computer name to copy profile to"

$user = get-aduser $prompt1 -Properties *
###
$name = $user.name 
$title= $user.title 
$username = $user.mailnickname 
$local_username = "***";
$Signature = Get-Content C:\Users\$local_username\Desktop\Signature_creator\signature_template_.txt

###Copy Profile 
robocopy \\$target_computer\c$\Users\$prompt1\Desktop \\$new_computer\c$\Users\$prompt1\Desktop 
robocopy \\$target_computer\c$\Users\$prompt1\Documents \\$new_computer\c$\Users\$prompt1\Documents
robocopy \\$target_computer\c$\Users\$prompt1\Downloads \\$new_computer\c$\Users\$prompt1\Downloads
robocopy \\$target_computer\c$\Users\$prompt1\Favorites \\$new_computer\c$\Users\$prompt1\Favorites   
#Copy chrome bookmarks
robocopy "\\$target_computer\c$\Users\$prompt1\AppData\Local\Google\Chrome\User Data\Default\Bookmarks" "\\$new_computer\c$\Users\$prompt1\AppData\Local\Google\Chrome\User Data\Default" 
robocopy "\\$target_computer\c$\Users\$prompt1\AppData\Local\Google\Chrome\User Data\Default\Bookmarks.bak" "\\$new_computer\c$\Users\$prompt1\AppData\Local\Google\Chrome\User Data\Default" 


#creates the signature locally 
function create_signature {

#template in HTML
(Get-Content C:\Users\$local_username\Desktop\Signature_creator\Signature_template_.txt).replace('$name', $name) | Set-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\v1.txt
(Get-Content  C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\v1.txt).replace('$title', $title) | Set-Content  C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\v2.txt
(Get-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\v2.txt).replace('$extension', $extension) | Set-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\v3.txt
(Get-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\v3.txt).replace('$username', $username) | Set-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\final.htm

Get-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\v3.txt | Set-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\final_text.txt
Get-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\v3.txt | Set-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\final_rtf.rtf}

create_signature

#copies to target MS signature folder
function copy_sigs {

New-Item \\$new_computer\c$\Users\$username\AppData\Roaming\Microsoft\Signatures -type directory

Copy-Item -Path C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\final_.rtf -Destination \\$new_computer\c$\Users\$username\AppData\Roaming\Microsoft\Signatures
Copy-Item -Path C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\final_text.txt -Destination \\$new_computer\c$\Users\$username\AppData\Roaming\Microsoft\Signatures
Copy-Item -Path C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\final.htm -Destination \\$new_computer\c$\Users\$username\AppData\Roaming\Microsoft\Signatures}

copy_sigs

robocopy C:\Users\$local_username\Desktop\Signature_creator\_Desktop \\$target_computer\c$\Users\$username\Desktop 


Set-ADComputer $new_computer -Description $name
set-adcomputer $target_computer -Description $name'_old'}



else {


write-host 'Computer name does not match' -BackgroundColor red




}

    


