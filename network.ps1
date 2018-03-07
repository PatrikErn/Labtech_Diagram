#Documentation http://psgraph.readthedocs.io
# Module made by Kevin Marquette
######################################
# Script made by
# Patrik Ernholdt
#
# Experimental build v0.010
#   Requires Module PSGraph
#  https://github.com/KevinMarquette/PSGraph/tree/master/docs
#
#  What it does and features: Graph a crude picture of your current Client and Computers inventory with corresponding locations. It gives and overview on Memory Total , IP-Address, Router Address , and domain.
#               You will also see what devices are servers by coloring.
#               It can handle if the devices are not in the same domain and will color all that are in workgroup, since that will show up in device information as well.
#
#  Preparing your data:                                                                                                                              
#  Pull data from ConnectWise Automate Data view : Network
#  Make sure you have following columns :
#      ComputerID,Agent Windows Domain,Client Name,Agent Name,Location Name,LocationID,Agent IP Address,Agent Router Address,Agent Type,Agent Memory Total,Agent Mainboard,Agent Serial Number,Agent Operating System,Agent OS Version,Agent MAC
#      Export as csv , remove spaces from Client Name , Location Name and Agent Name.                                                             
#####################################
#   Headers in CSV-file
#   ComputerID,Agent Windows Domain,Client Name,Agent Name,Location Name,LocationID,Agent IP Address,Agent Router Address,Agent Type,Agent Memory Total,Agent Mainboard,Agent Serial Number,Agent Operating System,Agent OS Version,Agent MAC
#   88,Customer1.local,Customer1,SRV001,Office1,35,172.18.60.110,10.10.10.1,Server,4096,VMware Virtual Platform,Serial01,Microsoft Windows Server 2012 R2 Standard x64,6.3.9600 ,00-02-20-A8-64-E7
#   
##Import Module
Import-Module PSGraph

#Path
$selfPath = (Get-Item -Path "." -Verbose).FullName
$dllRelativePath = "........"
$dllAbsolutePath = Join-Path $selfPath $dllRelativePath
#Csv
 $csv = Import-Csv $selfPath\network.csv


    #////////////////Graph\\\\\\\\\\\\\\\\\\\\# 

graph g @{rankdir='TB'} {
  
    $csv | ForEach-Object {
Entity $PSItem -Property ClientName -Name $PSItem.ClientName -Show Value
    }

    $csv | ForEach-Object {
Entity $PSItem -Property 'LocationName' , 'LocationID','Agent Router Address','Agent Windows Domain' -Name $PSItem.LocationName -Show Value
    }

    $csv | ForEach-Object {
Entity $PSItem -Property 'ComputerID','Agent IP Address','Agent Type','Agent Memory Total','Agent Mainboard','Agent Serial Number','Agent Operating System','Agent OS Version','Agent Windows Domain' -Name $PSItem.AgentName -Show Value
    }
     
    #////////////////Nodes\\\\\\\\\\\\\\\\\\\\#
        node $csv -NodeScript {$_.AgentName} @{style='filled';color='blue'}    
          
        node $csv.where({$_.'Agent Type' -eq 'Server'}) -NodeScript {$_.AgentName} @{shape='rect';style='filled';color='red'}
        node $csv.where({$_.'Agent Windows Domain' -Match 'workgroup'}) -NodeScript {$_.AgentName} @{shape='rect';style='filled';color='green'}
                           
            
     #////////////////Edges\\\\\\\\\\\\\\\\\\\\#              
            
      $csv |%{edge -From $_.ClientName -To $_.LocationName @{color='blue'}}         
      $csv |%{edge -From $_.LocationName -To $_.AgentName @{color='green'}}
            
      
#////////////////Inline\\\\\\\\\\\\\\\\\\\\#    
    inline 'label = "\n\Topology Map - Network and Servers\n\Drawn by Script\n\Written by Patrik Ernholdt"'
    inline 'fontsize=20' 
           }| Export-PSGraph -ShowGraph -LayoutEngine Hierarchical  -DestinationPath $selfPath\network.jpg