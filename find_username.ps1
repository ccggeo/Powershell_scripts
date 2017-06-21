$computername = read-host -Prompt "input Computer name"

$name = get-adcomputer $computername -properties description 

write-host 'User is:' $name.description -BackgroundColor Red 