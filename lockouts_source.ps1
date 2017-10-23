#Obtain user
$User = ""

#Specify DC
$DC = Get-ADDomainController  <DC>

#Collect lockout events for user based on time 

$timespan = new-timespan -hours 5 |Select-Object -ExpandProperty totalmilliseconds

Get-WinEvent -ComputerName $DC -Logname Security -FilterXPath "*[System[EventID=4740 and TimeCreated[timediff(@SystemTime) <= $timespan]] and EventData[Data[@Name='TargetUserName']='$User']]" |

Select-Object TimeCreated,@{Name='User Name';Expression={$_.Properties[0].Value}},@{Name='Source Host';Expression={$_.Properties[1].Value}}