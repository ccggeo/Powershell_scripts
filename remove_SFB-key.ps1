invoke-command -ComputerName bs-fp-0648DW -ScriptBlock{
pushd
sl "Registry::HKEY_CLASSES_ROOT\TypeLib\{2DF8D04C-5BFA-101B-BDE5-00AA0044DE52}"
$exists = test-path 2.8
if ($exists -eq $true)
{
write-host "SFB key exists, removing key..." -ForegroundColor Cyan
    #remove-item 2.8 
}
else
{ write-host "Key is already removed" -ForegroundColor green
    
}
}

#get-itemproperty  -path "Registry::HKEY_CLASSES_ROOT\TypeLib\{2DF8D04C-5BFA-101B-BDE5-00AA0044DE52}\2.8"  }