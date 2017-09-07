$path_ = read-host "Enter path to search" 
$extension_ = read-host "Enter extension" 


$Dir = get-childitem "$path_" -recurse
$List = $Dir | where {$_.extension -eq ".$extension_"}
$List |  ft fullname |out-file C:\Scripts\$extension_.txt