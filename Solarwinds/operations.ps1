import-module Swispowershell 

$swis = Connect-Swis 

Get-SwisData $swis "SELECT Name FROM Metadata.Property where EntityName = 'Orion.Nodes'" | export-csv c:\temp\properties_getswisdata.csv

Get-SwisData $swis "SELECT Name FROM Metadata.Property where EntityName = 'Orion.Nodes'"

Get-SwisData $swis "SELECT Name FROM Metadata.Property where EntityName = 'Orion.Nodes'"

#Get Windows 2012 machines in Solarwinds
Get-SwisData -SwisConnection $swis -Query 'SELECT NodeID, DisplayName, Description, IPAddress,  StatusDescription FROM Orion.Nodes WHERE Description = @D' @{ D = 'Windows 2012 R2 Server' } | FT

Get-SwisData -SwisConnection $swis -Query 'SELECT NodeID, DisplayName, Description, IPAddress, uri,  StatusDescription, Community FROM Orion.Nodes' 


#get properties of Solarwinds object 
Get-SwisObject $swis -Uri "swis://SOLARWINDS.blacksun.com/Orion/Orion.Nodes/NodeID=217" | Sort-Object -Property key

#$newNodeUri = New-SwisObject $swis -EntityType "Orion.NodesCustomProperties" -Properties $newNodeProps




