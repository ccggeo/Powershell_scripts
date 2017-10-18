#get-mobiledevice  | select identity, devicetype, deviceuseragent, DeviceOS, Devicemodel, Firstsynctime, Ismanaged, iscompliant, isdisabled | Out-GridView


$users = get-aduser -SearchBase "(((" -Filter {enabled -eq $true}  -properties *

$x = $users.mailnickname 
$output= @()

$x | % {

$line = '' | select username, connected_devices_Total, devicetype, deviceuseragent, DeviceOS, Devicemodel, Firstsynctime
$usermobiles = get-mobiledevice -Mailbox $_ |select devicetype, deviceuseragent, DeviceOS, Devicemodel, Firstsynctime, Ismanaged, iscompliant, isdisabled


$line.username = $_
$line.connected_devices_Total = $usermobiles.count
$line.devicetype = $usermobiles.devicetype -join ', '
$line.deviceuseragent = $usermobiles.deviceuseragent -join ', '
$line.DeviceOS = $usermobiles.deviceOS -join ', '
$line.Devicemodel = $usermobiles.devicemodel -join ', '
$line.Firstsynctime = $usermobiles.firstsynctime -join ', '


$line
$output += $line 

 

}



$output | export-csv c:\scripts\mobileExport.csv