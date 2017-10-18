$openFiles = get-smbopenfile -CimSession <server>  | Where-Object {$_.path -like "**"}


$openFiles | Sort-Object -Property path

$fileID = $openFiles.fileid
$fileID

$fileID | %{
Close-SmbOpenFile -CimSession <server> $_ }
$fileID


