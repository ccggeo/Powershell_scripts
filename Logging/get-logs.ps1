# get last written file in log directory
$logfilefolder = "***"
$logfile = (Get-ChildItem $logfilefolder | Sort-Object LastWriteTime -Descending)[0].FullName
 
write-host "Using $logfile"
get-content $logfile  -Wait | % {
 
 
 
    if ($_ -like "**" )
    {
        $_
    }
   
    }