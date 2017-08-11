$User = "***"
$SecurePass =  Read-Host "enter password" -AsSecureString
$credential = New-Object System.Management.Automation.PSCredential $User, $SecurePass

Get-Credential $credential 
$hostname = hostname 

Enter-PSSession -ComputerName $hostname -Credential $credential