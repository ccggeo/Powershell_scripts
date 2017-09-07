#force log off all users from  room PCs 

            $x = Read-Host -Prompt 'Input first two letters of room name' 


            if ($x -eq "" -or $x -eq '')
            {
             try {
           
           
            write-host ' selected: checking for logged on users...'-ForegroundColor cyan
            $user_gr= Get-CimInstance –ComputerName  –ClassName Win32_ComputerSystem 
                   
            Invoke-CimMethod -ClassName Win32_Operatingsystem -ComputerName   -MethodName Win32Shutdown -Arguments @{ Flags = 4 } -ErrorAction Stop | out-null
            write-host $user_gr.username 'currently logged on...' -ForegroundColor yellow

            write-host 'All users now logged off' -ForegroundColor green 


            }

            catch{write-host 'no one is logged onto ' -BackgroundColor red}
            
            }

            else { 

            if ($x -eq "" -or $x -eq '')
{
                   try {
                     
            write-host ' selected: checking for logged on users...'-ForegroundColor cyan
            $user_po= Get-CimInstance –ComputerName  –ClassName Win32_ComputerSystem 
            
            Invoke-CimMethod -ClassName Win32_Operatingsystem -ComputerName  -MethodName Win32Shutdown -Arguments @{ Flags = 4 } -ErrorAction Stop | out-null
            write-host $user_po.username 'currently logged on...' -ForegroundColor yellow
            write-host 'All users now logged off' -ForegroundColor green 


            }

            catch{write-host 'no one is logged onto ' -BackgroundColor red}                                   
                                     
                                     }


                        else {

                if ($x -eq "" -or $x -eq '')
                {
                                 try {
           
           
            write-host ' selected: checking for logged on users...'-ForegroundColor cyan
            
            write-host $user_sa.username 'currently logged on...' -ForegroundColor yellow

            Invoke-CimMethod -ClassName Win32_Operatingsystem -ComputerName   -MethodName Win32Shutdown -Arguments @{ Flags = 4 } -ErrorAction Stop | out-null
            $user_sa= Get-CimInstance –ComputerName  –ClassName Win32_ComputerSystem 
            write-host 'All users now logged off' -ForegroundColor green 


            }


            catch{write-host 'no one is logged onto ' -BackgroundColor red}
                
         

                
                }
                else{
          
                
                             
                if ($x -eq "" -or $x -eq '')
                {
                     try {
           
           
            write-host ' selected: checking for logged on users...'-ForegroundColor cyan
            
            write-host $user_tu.username 'currently logged on...' -ForegroundColor yellow

            Invoke-CimMethod -ClassName Win32_Operatingsystem -ComputerName   -MethodName Win32Shutdown -Arguments @{ Flags = 4 } -ErrorAction Stop | out-null
            $user_tu= Get-CimInstance –ComputerName  –ClassName Win32_ComputerSystem 
            write-host 'All users now logged off' -ForegroundColor green 


            }


            catch{write-host 'no one is logged onto ' -BackgroundColor red}                           
                   
                } 
                                                    
                else{
                
                if ($x -eq "" -or $x -eq 're')
                {
                                try {
                
            write-host ' selected: checking for logged on users...'-ForegroundColor cyan
            
            write-host $user_re.username 'currently logged on...' -ForegroundColor yellow
        
            Invoke-CimMethod -ClassName Win32_Operatingsystem -ComputerName   -MethodName Win32Shutdown -Arguments @{ Flags = 4 } -ErrorAction Stop | out-null
            $user_re= Get-CimInstance –ComputerName  –ClassName Win32_ComputerSystem 
            write-host 'All users now logged off' -ForegroundColor green 

            }

            catch{write-host 'no one is logged onto Reception' -BackgroundColor red}
   
                
                }
                else {write-host $x 'is not a valid BS computer name ' -BackgroundColor RED }                 
           
                }
                
                }

                }

}