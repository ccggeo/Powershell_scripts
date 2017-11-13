$user = ""

invoke-command -computername <> -ScriptBlock{



$objUser = New-Object System.Security.Principal.NTAccount("$user")
$strSID = $objUser.Translate([System.Security.Principal.SecurityIdentifier])

$SID = $strSID.Value

Set-ItemProperty "Microsoft.PowerShell.Core\Registry::HKEY_USERS\$SID\SOFTWARE\Policies\Microsoft\office\15.0\outlook\cached mode" -Name "cachedexchangemode" -Value 0


$days = (Get-ItemProperty "Microsoft.PowerShell.Core\Registry::HKEY_USERS\$SID\SOFTWARE\Policies\Microsoft\office\15.0\outlook\cached mode" -Name "cachedexchangemode").cachedexchangemode

write-host "Mail to keep offline = $days days" -ForegroundColor green 

}