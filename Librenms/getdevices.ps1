$HTTPHeaders = @{}

$HTTPHeaders.Add('X-Auth-Token', '')

# GET example
$URL = ''
$devices = Invoke-RestMethod -Method Get -Uri $URL -Headers $HTTPHeaders 

$d = $devices.devices 

$d.sysname 
