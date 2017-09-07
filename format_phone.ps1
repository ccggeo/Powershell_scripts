 $ad_usersss= Get-ADUser -SearchBase "" -Filter 'Enabled -eq $True' -Properties *
 $sfbphone = $ad_usersss

 $sfbphone | %{
 
    $phone = $_.officephone

    write-host "old format: $phone" -ForegroundColor darkYellow

    $phone = $phone.replace(' ','')
    $phone = $phone.replace('(','')
    $phone = $phone.replace(')','')


    $phone= $phone.Insert(3," ")
    $phone= $phone.Insert(4,"(")
    $phone= $phone.Insert(5,"0")
    $phone= $phone.Insert(6,")")
    $phone= $phone.Insert(11," ")
    $phone= $phone.Insert(15," ")

    set-aduser -Identity $_ -officephone $phone
    write-host "new format: $phone" -ForegroundColor Green
}
