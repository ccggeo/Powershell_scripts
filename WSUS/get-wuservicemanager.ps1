#because wu module returns data as a series of objects, I had to find a different way of using its gathered data for reporting by spliting these objects into elements within an array and then finding the properties of each object from that array. 

$hostname = ""
$wu = (invoke-command -ComputerName $hostname -ScriptBlock {get-wuservicemanager})

$a = @() #array holding name data 
$itemnumber = $wu.count 
$a += $wu
$output= @() #holding wu name data 

            $First = ($a[0]).name
            $second = ($a[0]).ismanaged
            $third = ($a[0]).IsDefaultAUService
           
           
           # $fourth = $a[3]
           # $fifth = $a[4]


			$obj = New-Object -TypeName PSObject
			$obj | Add-Member -MemberType NoteProperty -Name Name -Value $first
			$obj | Add-Member -MemberType NoteProperty -Name Ismanaged -Value $second
            $obj | Add-Member -MemberType NoteProperty -Name IsDefaultAUService -Value $third
            $obj | Add-Member -MemberType NoteProperty -Name hostname -Value "$hostname"

$output += $obj 

            $First = ($a[1]).name
            $second = ($a[1]).ismanaged
            $third = ($a[1]).IsDefaultAUService
           
			$obj = New-Object -TypeName PSObject
			$obj | Add-Member -MemberType NoteProperty -Name Name -Value $first
			$obj | Add-Member -MemberType NoteProperty -Name Ismanaged -Value $second
            $obj | Add-Member -MemberType NoteProperty -Name IsDefaultAUService -Value $third
            $obj | Add-Member -MemberType NoteProperty -Name hostname -Value "$hostname"

$output += $obj 


            $First = ($a[2]).name
            $second = ($a[2]).ismanaged
            $third = ($a[2]).IsDefaultAUService
           
           
           # $fourth = $a[3]
           # $fifth = $a[4]


			$obj = New-Object -TypeName PSObject
			$obj | Add-Member -MemberType NoteProperty -Name Name -Value $first
			$obj | Add-Member -MemberType NoteProperty -Name Ismanaged -Value $second
            $obj | Add-Member -MemberType NoteProperty -Name IsDefaultAUService -Value $third
            $obj | Add-Member -MemberType NoteProperty -Name hostname -Value "$hostname"


            $First = ($a[3]).name
            $second = ($a[3]).ismanaged
            $third = ($a[3]).IsDefaultAUService
           
           


			$obj = New-Object -TypeName PSObject
			$obj | Add-Member -MemberType NoteProperty -Name Name -Value $first
			$obj | Add-Member -MemberType NoteProperty -Name Ismanaged -Value $second
            $obj | Add-Member -MemberType NoteProperty -Name IsDefaultAUService -Value $third
            $obj | Add-Member -MemberType NoteProperty -Name hostname -Value "$hostname"

$output += $obj 
         
            $First = ($a[4]).name
            $second = ($a[4]).ismanaged
            $third = ($a[4]).IsDefaultAUService
           
           

			$obj = New-Object -TypeName PSObject
			$obj | Add-Member -MemberType NoteProperty -Name Name -Value $first
			$obj | Add-Member -MemberType NoteProperty -Name Ismanaged -Value $second
            $obj | Add-Member -MemberType NoteProperty -Name IsDefaultAUService -Value $third
            $obj | Add-Member -MemberType NoteProperty -Name hostname -Value "$hostname"

$output += $obj 
         