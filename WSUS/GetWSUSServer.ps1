$y = get-adcomputer -searchbase "" -filter * -properties * | select name 

$output= @()

$y | % {

$BOOL = Test-Connection -Computername $y -BufferSize 16 -Count 1 -Quiet

if ($BOOL -eq $TRUE)
{ write-host "processing $Y" -foregroundcolor green
    
$line = '' | select PSComputername, wsusstatus 

$wsusstatus = (get-itemproperty Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate).WUSERVER 

$line.PSComputername = $_ | out-string
$line.wsusstatus = $wsusstatus | out-string

$line
$output += $line 

$output


}

else {

    write-host "$_ is offline" -ForegroundColor red 


}


}



