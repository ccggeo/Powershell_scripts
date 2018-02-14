
import-module Swispowershell 

$swis = Connect-Swis 


$ip = "10.0.0.118"

# add a node
$newNodeProps = @{
    IPAddress = $ip;
    EngineID = 1;
  
    # SNMP v2 specific
    ObjectSubType = "SNMP";

    SNMPVersion = 2;

   # DNS = "";
   # SysName = "";
    
    # === default values ===

    # EntityType = 'Orion.Nodes'
    # Caption = ''
    # DynamicIP = false
    # PollInterval = 120
    # RediscoveryInterval = 30
    # StatCollection = 10  
}

$newNodeUri = New-SwisObject $swis -EntityType "Orion.Nodes" -Properties $newNodeProps






#https://thwack.solarwinds.com/thread/52564

<#

$nodeProps = Get-SwisObject $swis -Uri $newNodeUri

# register specific pollers for the node
$poller = @{
    NetObject="N:"+$nodeProps["NodeID"];
    NetObjectType="N";
    NetObjectID=$nodeProps["NodeID"];
}

# Status
$poller["PollerType"]="N.Status.ICMP.Native";
$pollerUri = New-SwisObject $swis -EntityType "Orion.Pollers" -Properties $poller

# Response time
$poller["PollerType"]="N.ResponseTime.ICMP.Native";
$pollerUri = New-SwisObject $swis -EntityType "Orion.Pollers" -Properties $poller

# Details
$poller["PollerType"]="N.Details.SNMP.Generic";
$pollerUri = New-SwisObject $swis -EntityType "Orion.Pollers" -Properties $poller

# Uptime
$poller["PollerType"]="N.Uptime.SNMP.Generic";
$pollerUri = New-SwisObject $swis -EntityType "Orion.Pollers" -Properties $poller

# CPU
$poller["PollerType"]="N.Cpu.SNMP.CiscoGen3";
$pollerUri = New-SwisObject $swis -EntityType "Orion.Pollers" -Properties $poller

# Memory
$poller["PollerType"]="N.Memory.SNMP.CiscoGen3";
$pollerUri = New-SwisObject $swis -EntityType "Orion.Pollers" -Properties $poller#>