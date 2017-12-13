#create signature 
$new_user_name = "Maya Jane"

#creates the signature locally 
function create-signature {

param($adusername)

$name = $new_user_name
$username = $user.mailnickname 
$local_username = ""
$Signature = Get-Content C:\Users\$local_username\Desktop\Signature_creator\signature_template_.txt


write-host "Creating $name signature"

#template in HTML with placeholders
(Get-Content C:\Users\$local_username\Desktop\Signature_creator\Signature_template_.txt).replace('$name', $name) | Set-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\v1.txt
(Get-Content  C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\v1.txt).replace('$title', $title) | Set-Content  C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\v2.txt
(Get-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\v2.txt).replace('$phone', $sfbphone) | Set-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\v3.txt
(Get-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\v3.txt).replace('$username', $username) | Set-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\final.htm

Get-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\v3.txt | Set-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\final_text.txt
Get-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\v3.txt | Set-Content C:\Users\$local_username\Desktop\Signature_creator\PS_Tests\final_rtf.rtf}



create-signature -adusername $new_user_name

