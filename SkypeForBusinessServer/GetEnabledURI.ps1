

$username = (get-csuser).samaccountname
 $output= @()

$username | % {




        $x = (get-csuser $_)
        $enabled = $x.ExUmEnabled

     

        if ($enabled -eq "true")
            {
            write-host "$_ enabled" -foregroundcolor green 
           $line = '' | select user, lineuri 

         $line.user = $_ | out-string
         $line.lineuri = $x.lineuri | out-string

            $output += $line

    
            }




        else
            {
                write-host "user $_ disabled for SFB" -ForegroundColor red 

            }

          $output | Out-GridView

}


