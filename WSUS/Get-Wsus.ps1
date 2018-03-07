$wsuscomps = "bs-fp-0551DW", "bs-fp-0637DW", "bs-fp-0635DW"

$output= @()

$wsuscomps | % {
$line = '' | select PSComputername, serviceid, ismanaged, IsDefaultAUService, name, ServiceUrl, CanRegisterWithAU

$data = invoke-command -ComputerName $_ -ScriptBlock{Get-WUServiceManager}
$serviceid = $data.serviceid


$line.serviceid = $serviceid | out-string
$line.ismanaged = $data.ismanaged | out-string
$line.IsDefaultAUService = $data.IsDefaultAUService | out-string
$line.name = $data.name | out-string
$line.ServiceUrl = $data.ServiceUrl | out-string
$line.CanRegisterWithAU = $data.CanRegisterWithAU | out-string
$line.PSComputername = $data.PSComputername | out-string

$line
$output += $line 


$output


}


$output | export-CSV c:\temp\wsus_pool.csv