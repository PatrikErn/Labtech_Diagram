#Documentation http://psgraph.readthedocs.io
# Module made by Kevin Marquette
######################################
# Script made by
# Patrik Ernholdt
#
# Experimental build V0.5
#   Requires Module PSGraph
#  https://github.com/KevinMarquette/PSGraph/tree/master/docs
#
#  What it does and features: 
#  Makes a diagram on how mapped network drives are used through a domain.
#  It will see if your network drive is offline , if it is connected through domain or a workgroup.
#  Change layout model by uncommenting any value.
#
#  Preparing your data:                                                                                                                              
# You get the data from the Connectwise Automate plugin Map Drives
# http://www.squidworks.net/2014/08/labtech-map-drives-plugin-shows-you-mappings-by-client/
#                                                           
#####################################
#   Headers and rows in CSV-file
#   ComputerID, Computer Name, Location Name, Drive Letter, Mount Point, User, Domain, Online, Last Contact
#   1,Server02,Location1,I,\\Server02\ltshare,Server02\Administrator,WORKGROUP,Yes,2018-06-14 10:46:27
#   
##Import Module
Import-Module PSGraph

#Path
$selfPath = (Get-Item -Path "." -Verbose).FullName
$dllRelativePath = "........"
$dllAbsolutePath = Join-Path $selfPath $dllRelativePath
#Csv
$csv = Import-Csv $selfPath\NetworkDrive.csv -Encoding UTF8  

      #////////////////Graph\\\\\\\\\\\\\\\\\\\\# 

graph "Drives" @{rankdir='TB';concentrate='true';splines='line';nodesep='5';ranksep='5';edgesep='5'} {
    
 #////////////////////Records\\\\\\\\\\\\#     
$csv | ForEach-Object {
Entity $PSItem -Property 'Computer Name'  -Name $PSItem.'Computer Name' -Show Value
    }
    $csv | ForEach-Object {
Entity $PSItem -Property 'Computer Name' ,'Domain', 'Drive Letter','Mount Point','User','Online' -Name $PSItem.'Mount Point' -Show Value
    }
  
#////////////////Nodes\\\\\\\\\\\\\\\\\\\\#         
         
        node $csv -NodeScript {$_.'Mount Point'} @{shape='rect';fillcolor='green'}            
        node $csv.where({$_.'Online' -eq 'No'}) -NodeScript {$_.'Mount Point'} @{fillcolor='red'}
        node $csv.where({$_.'Domain' -like 'workgroup'}) -NodeScript {$_.'Mount Point'} @{fillcolor='turquoise'}
       
                        
            
     #////////////////Edges\\\\\\\\\\\\\\\\\\\\# 
         
   $csv | %{edge -From $_.'Computer Name'  -To $_.'Mount Point' @{group='true'}}
                
      
#////////////////Inline\\\\\\\\\\\\\\\\\\\\#    
    inline 'label = "\n\Mapped Network Folders\n\Drawn by NetworkDrives Script\n\Written by Patrik Ernholdt"'
    inline 'fontsize=20' 
    #///////////////Legend\\\\\\\\\\\\\\\\\\\\#
    inline     'subgraph cluster0 {
     legend [ label=" {Legend  | {Red | Drive Disconnected}| {Green|Drive online and in domain}|Turquoise| Not domain connected}",shape=record]
            } '
           }| 
          #Export-PSGraph -ShowGraph -LayoutEngine Circular  -DestinationPath $selfPath\networkdrive_circ.jpg
          Export-PSGraph -ShowGraph -LayoutEngine Hierarchical  -DestinationPath $selfPath\networkdrive_hierc.jpg
          #Export-PSGraph -ShowGraph -LayoutEngine SpringModelLarge  -DestinationPath $selfPath\networkdrive_Sprmdl.jpg
          #Export-PSGraph -ShowGraph -LayoutEngine Radial  -DestinationPath $selfPath\networkdrive_radi.jpg
           
