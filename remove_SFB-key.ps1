invoke-command -computername -scriptblock{sl "Registry::HKEY_CLASSES_ROOT\TypeLib\{2DF8D04C-5BFA-101B-BDE5-00AA0044DE52}"
$exists = test-path 2.8
if ($exists -eq $true)
{
write-host "SFB key exists, removing key..." -ForegroundColor Cyan
remove-item 2.8 
  
}
else
{ write-host "SFB Key is already removed" -ForegroundColor green
    
}

#reset searching index
set-ItemProperty -path "HKLM:\Software\Microsoft\Windows Search" -Name SetupCompletedSuccessfully -Value 0
Stop-Service wsearch
Start-Service wsearch

$services = get-service -Name wsearch

write-host 'Wsearch is now'$services.status -ForegroundColor yellow }