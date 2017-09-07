$Dir = get-childitem "" -recurse
# $Dir |get-member
$List = $Dir | where {$_.extension -eq ".indd"}
$List |  ft fullname |out-file C:\Scripts\indd.txt
# List | format-table name