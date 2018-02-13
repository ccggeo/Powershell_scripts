$HTTPHeaders = @{}

$HTTPHeaders.Add('X-Auth-Token', '')

$URL = ''

$body = @{}
$body.add("hostname", "")
$body.add("community", "")
$body.add("force_add", "$TRUE")
$body.add("version", "")


$JSON = $body | ConvertTo-Json 

Invoke-RestMethod -Method POST -Uri $URL -Headers $HTTPHeaders -Body $JSON -Verbose



