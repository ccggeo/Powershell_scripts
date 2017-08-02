$computer_name = read-host -Prompt "Confirm computer name"  

$User = get-adcomputer $computer_name -Properties * 
$user =$user.description

robocopy \\$computer_name\c$\windows\minidump C:\temp\BSOD_dumps\$user'_dump'