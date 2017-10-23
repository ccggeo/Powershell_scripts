$openFiles = get-smbopenfile -CimSession <server>  | Where-Object {$_.path -like "**"} 

$openFiles | select   ClientUserName, path, FileId

$fileID = $openFiles.fileid

$x = read-host 'Would you like to close these files?'

if ($x -eq "Y" -or $x -eq "y")
{
   $fileID | %{
    Close-SmbOpenFile -fileid $_ -CimSession <server>  -Force}

   }



