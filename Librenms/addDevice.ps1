$HTTPHeaders = @{}

$HTTPHeaders.Add('X-Auth-Token', '')

$URL = ''

$body = @{}
$body.add("hostname", "")
$body.add("Community", "")
$body.add("force_add", "$TRUE")
$body.add("version", "v1")

$JSON = $body | ConvertTo-Json 

Invoke-RestMethod -Method POST -Uri $URL -Headers $HTTPHeaders -Body $JSON -Verbose