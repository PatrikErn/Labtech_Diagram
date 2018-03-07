# Labtech_Diagram
Powershell script to automatically draw a simple topology from ConnectWise Automate 

#  What it does and features: Graph a crude picture of your current Client and Computers inventory with corresponding locations. It gives and overview on Memory Total , IP-Address, Router Address , and domain.
#               You will also see what devices are servers by coloring.
#               It can handle if the devices are not in the same domain and will color all that are in workgroup, since that will show up in device information as well.
#
#  Preparing your data:                                                                                                                              
#  Pull data from ConnectWise Automate Data view : Network
#  Make sure you have following columns :
#      ComputerID,Agent Windows Domain,Client Name,Agent Name,Location Name,LocationID,Agent IP Address,Agent Router Address,Agent Type,Agent Memory Total,Agent Mainboard,Agent Serial Number,Agent Operating System,Agent OS Version,Agent MAC
#      Export as csv , remove spaces from Client Name , Location Name and Agent Name.
