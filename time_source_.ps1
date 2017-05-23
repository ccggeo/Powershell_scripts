$computers= Get-ADComputer -SearchBase "searchbase"-Filter {enabled -eq $true} 
 
$output= @()
$computers| % {
    
    $line= '' | Select DNSHostname,Timesource
    $line.DNSHostname = $_.DNSHostname
   # Start-Transcript
    Write-Host -ForegroundColor Yellow "Testing $($_.DNSHostname)"
    if (Test-WSMan $_.DNSHostname -ErrorAction SilentlyContinue )

    {
        Write-Host -ForegroundColor Green "Connected to $($_.DNSHostname)"
       
        $line.Timesource = Invoke-Command -ComputerName $_.DNSHostname -ScriptBlock { w32tm /query /source}
      
      
      ### check if service is running
        $time_service = Invoke-Command -ComputerName $_ -ScriptBlock { get-service -Name w32time}
         if ( $time_service.status -eq "running") 
            {write-host -foregroundcolor green "----------Service is running----------"}
            
         else {write-host -ForegroundColor red "Time service is not running attempting to start service"
               Invoke-Command -ComputerName $_.DNSHostname -ScriptBlock { 
               start-service -Name w32time
               $running? =  get-service -Name w32time
               write-host -foregroundcolor green "Time server status:" $running?.status
             }
             }


    }

        else {
            Write-Host -ForegroundColor Red "Cannot connect to $($_.DNSHostname)"
            $line.Timesource = "Error"

        }
        $line
        $output +=$line
}
 

 
$timestamp = $(get-date -Format ddMMyyyy)
$output | export-csv "c:\temp\Time_server_exports\$timestamp.csv"
