#edit these variables to change values of signature
$prompt1 = read-host -Prompt "Input username"
$target_computer = read-host -Prompt "Input Computer name"
$extension = read-host -Prompt "Input Extension"

$user = get-aduser $prompt1 -Properties *
###
$name = $user.name 
$title= $user.title 
$username = $user.mailnickname 
$local_username = "***";
$Signature = Get-Content C:\Users\$local_username\Desktop\Signature_creator\signature_template_.txt


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

New-Item \\$target_computer\c$\Users\$username\AppData\Roaming\Microsoft\Signatures -type directory

Copy-Item -Path C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\final_.rtf -Destination \\$target_computer\c$\Users\$username\AppData\Roaming\Microsoft\Signatures
Copy-Item -Path C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\final_text.txt -Destination \\$target_computer\c$\Users\$username\AppData\Roaming\Microsoft\Signatures
Copy-Item -Path C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\final.htm -Destination \\$target_computer\c$\Users\$username\AppData\Roaming\Microsoft\Signatures}

copy_sigs

robocopy C:\Users\$local_username\Desktop\Signature_creator\_Desktop \\$target_computer\c$\Users\$username\Desktop 
Set-ADComputer $target_computer -Description $name