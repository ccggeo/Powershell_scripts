
############################ Part 1############################################ 
#Gets the names of enabled domain workstations only. Ignores servers.

#empty array holding workstations to test
$computers = @() 

#Grabs Desktop workstations
$computers_obj =  Get-ADComputer -filter {(enabled -eq $true) -and (name  -like '<example>')} -Properties Name | select Name  

$computers_obj | % {

   $computers += $_.name

}

#grabs Virtual windows workstations

$computers_obj =  Get-ADComputer -filter {(enabled -eq $true) -and (name  -like '<example>')} -Properties Name | select Name 
    
    $computers_obj | % {

        $computers += $_.name

                }

#grabs  windows laptops

$computers_obj =  Get-ADComputer -filter {(enabled -eq $true) -and (name  -like '<example>')} -Properties Name | select Name
    $computers_obj | % {

                $computers += $_.name

                }


##array holding online computers 
$computersArr =@()

  #test if computer is online and if true increment an array
 foreach($computer in $computers){

  # Is the computer online
  $isup = Test-Connection -Count 1 -Quiet -ComputerName $computer
   
    if($isup -eq $true){
    write-host ""$computer "is online" -foreground "green"
        #Add online computers to empty array
        $computersArr += $computer

        }
     else {write-host ""$computer "is offline" -foreground "red"}
}

##array holding online computers
#Write-host "Online computers in Domain currently" -ForegroundColor Green
#$computersArr 



#######################################################################################################
#Part 2 iterates through online computers, finds release ID and places data including name and releaseid into an array for output. 

#empty array to hold data for export 

    $output =@()

  
    
    foreach($machine in $computersArr){

    # creates the object with properties you select. Much like naming rows 'names and releae id'
    $line = '' | select name, releaseid 

    #create object with releaseid data. 
    $releaseid = (Invoke-Command -ComputerName $machine -ScriptBlock {Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name releaseid}).releaseid 

    #Set the properties you defined in $line. Name will be set to $machine and releaseid will be set to $releaseid
    $line.name = $machine
    $line.releaseid = $releaseid
     
     Start-Sleep -Milliseconds 200
     
     #append data to array for export 
     $output += $line 






        }
        #exports to CSV
        $output | export-csv C:\scripts\release_ID_export.csv 