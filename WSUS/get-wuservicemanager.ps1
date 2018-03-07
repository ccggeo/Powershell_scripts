#because wu module returns data as a series of objects, I had to find a different way of using its gathered data for reporting by spliting these objects into elements within an array and then finding the properties of each object from that array. 

$hostname = ""
$wu = (invoke-command -ComputerName $hostname -ScriptBlock {get-wuservicemanager})

$a = @() #array holding name data 
$itemnumber = $wu.count 
$a += $wu
$output= @() #holding wu name data 
$i = 0

Do{
            $First = ($a[$i]).name
            $second = ($a[$i]).ismanaged
            $third = ($a[$i]).IsDefaultAUService


			$obj = New-Object -TypeName PSObject
			$obj | Add-Member -MemberType NoteProperty -Name Name -Value $first
			$obj | Add-Member -MemberType NoteProperty -Name Ismanaged -Value $second
            $obj | Add-Member -MemberType NoteProperty -Name IsDefaultAUService -Value $third
            $obj | Add-Member -MemberType NoteProperty -Name hostname -Value "$hostname"

$output += $obj 



    $i++
    
    
    }Until ($i -eq $itemnumber)

    $output

