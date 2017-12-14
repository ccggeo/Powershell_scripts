#create signature 
$new_user_name = Read-host 'Enter username of new signature'  

#creates the signature locally 
function create-signature {


 Param
        (
            [Parameter(Mandatory=$true)]
        
            $adusername)

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

create-signature -adusername $new_user_name

