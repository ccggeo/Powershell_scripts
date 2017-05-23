$computers= Get-ADComputer-SearchBase "searchbase"-Filter {enabled -eq $true} 
 
$output= @()
$computers| % {
    
    $line= '' | Select DNSHostname,Timesource
    $line.DNSHostname = $_.DNSHostname
    Write-Host -ForegroundColorYellow "Testing $($_.DNSHostname)"
    if (Test-WSMan$_.DNSHostname -ErrorAction SilentlyContinue )
    {
        Write-Host -ForegroundColorGreen "Connected to $($_.DNSHostname)"
        $line.Timesource = Invoke-Command-ComputerName $_.DNSHostname -ScriptBlock { w32tm/query /source}
    }
        else {
            Write-Host -ForegroundColorRed "Cannot connect to $($_.DNSHostname)"
            $line.Timesource = "Error"
        }
        $line
        $output +=$line
}
 
$output| Out-GridView
 
