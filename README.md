Labtech_Diagram
Powershell script to automatically draw a simple topology from ConnectWise Automate.

 Features: 
 Graph a picture of your current Client and Computers inventory with corresponding locations.
 It gives an overview on Memory Total , IP-Address, Router Address , and domain.
 Server will be marked with red double boxes.
 If a device is not in a domain, and in WORKGROUP its box will be green.
 
 Right now it draws the topology from top to bottom.
 You can change that easily by @{rankdir='TB'} to LR for left to right.
 To change Layout entirely: Change Hierarchical to Radial , Circular, Springmodel(Small](Medium)(Large)
  }| Export-PSGraph -ShowGraph -LayoutEngine Hierarchical 

  Preparing your data:                                                                                                                              
  Pull data from ConnectWise Automate Data view : Network
  Make sure you have following columns :
      ComputerID,Agent Windows Domain,Client Name,Agent Name,Location Name,LocationID,Agent IP Address,Agent Router Address,Agent Type,Agent Memory Total,Agent Mainboard,Agent Serial Number,Agent Operating System,Agent OS Version,Agent MAC
Export as csv , remove spaces from Client Name , Location Name and Agent Name.



[Update 2018-03-8 | Fixed multiple arrows from edge ClientName to LocationName |  
[Update 2018-06-15| Added digram script to analyze mapped network drives
