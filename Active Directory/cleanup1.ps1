$data = import-csv C:\temp\For_AD.csv

$data | % {
$mac =  $_.Mac
$user = $_.User

set-adcomputer $mac -Description $user 
get-adcomputer $mac -Properties * | select Name, description 
}
