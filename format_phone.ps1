 function format_phone{
    $aduser = get-aduser <user> -Properties * 
    $sfbphone = $aduser.officephone 
    $sfbphone

    $sfbphone = $sfbphone.replace(' ','')

    $sfbphone= $sfbphone.Insert(3," ")
    $sfbphone= $sfbphone.Insert(4,"(")
    $sfbphone= $sfbphone.Insert(5,"0")
    $sfbphone= $sfbphone.Insert(6,")")
    $sfbphone= $sfbphone.Insert(11," ")
    $sfbphone= $sfbphone.Insert(15," ")

    set-aduser -Identity $aduser -officephone $SFBphone
    $sfbphone
    }

format_phone
