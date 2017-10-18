##get open files
$openFiles = get-smbopenfile -CimSession <server>  | Where-Object {$_.path -like "**"}

##sort by path
$openFiles | Sort-Object -Property path

$fileID = $openFiles.fileid
$fileID

$fileID | %{
Close-SmbOpenFile -CimSession <server> $_ }
$fileID


