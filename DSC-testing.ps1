Configuration Install7Zip
{Import-DscResource –ModuleName 'PSDesiredStateConfiguration'
     Node $env:ComputerName
     {
         Package Install7Zip
         {
             Ensure = 'Present'
             Name = '7-Zip 17.00'
             Path = 'C:\temp\7z1700.msi'
             ProductId = '23170F69-40C1-2701-1700-000001000000'
         }
     }

     }

     Install7Zip -outputpath c:\7zip




Configuration w32tm

{Import-DscResource –ModuleName 'PSDesiredStateConfiguration'
     Node $env:ComputerName

     {
         Service w32tm
                {
                    Name = "W32Time"
                    StartupType = "Automatic"
                    State = "Running"
                    Ensure = "Present"
                }


     }

     }

     w32tm -outputpath c:\Services

 #Start-DscConfiguration -path C:\Services -wait -Verbose -force


 Configuration smb1 
{Import-DscResource –ModuleName 'PSDesiredStateConfiguration'
       Node $env:ComputerName
    {
        Registry smb1
        {
            Ensure      = "Present" 
            Key         = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\ParametersRegistry"
            ValueName   = "SMB1"
            ValueData   = "0"
            ValueType   = "Dword"
        }
      }
}


smb1 -outputpath c:\Registry

#Start-DscConfiguration -path C:\Registry -wait -Verbose -force
