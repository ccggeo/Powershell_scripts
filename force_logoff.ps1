#force log off users from meeting room PCs. quick way to get meetings going asap and force all logged on previously off. 

$x = Read-Host -Prompt 'input room name'


if ($x -eq "X" -or $x -eq 'Y')
{
    write-host 'XY selected'-ForegroundColor Green

    #Invoke-CimMethod -ClassName Win32_Operatingsystem -ComputerName XY  -MethodName Win32Shutdown -Arguments @{ Flags = 4 }
}

else { 

if ($x -eq "X" -or $x -eq 'Y')
{
write-host 'XY selected'-ForegroundColor Green
#Invoke-CimMethod -ClassName Win32_Operatingsystem -ComputerName XY  -MethodName Win32Shutdown -Arguments @{ Flags = 4 }
}

else {

if ($x -eq "XY" -or $x -eq 'XY')
{
write-host 'XY selected'-ForegroundColor Green
#Invoke-CimMethod -ClassName Win32_Operatingsystem -ComputerNameXY  -MethodName Win32Shutdown -Arguments @{ Flags = 4 }
}
else{
                
if ($x -eq "XY" -or $x -eq 'XY')
{
write-host 'XY selected'-ForegroundColor Green
#Invoke-CimMethod -ClassName Win32_Operatingsystem -ComputerName XY  -MethodName Win32Shutdown -Arguments @{ Flags = 4 }
else {
                
                
                } 
                
                
                }

                
             
                
                }

                }


}

