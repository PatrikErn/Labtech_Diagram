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

NetworkDrives
Experimental build V0.5
  What it does and features: 
  Makes a diagram on how mapped network drives are used through a domain.
  It will see if your network drive is offline , if it is connected through domain or a workgroup.
  Change layout model by uncommenting any value.

  Preparing your data:                                                                                                                              
 You get the data from the Connectwise Automate plugin Map Drives
 http://www.squidworks.net/2014/08/labtech-map-drives-plugin-shows-you-mappings-by-client/#                                                           

   Headers and rows in CSV-file
   ComputerID, Computer Name, Location Name, Drive Letter, Mount Point, User, Domain, Online, Last Contact
   1,Server02,Location1,I,\\Server02\ltshare,Server02\Administrator,WORKGROUP,Yes,2018-06-14 10:46:27

[Update 2018-03-8 | Fixed multiple arrows from edge ClientName to LocationName |  
[Update 2018-06-15| Added digram script to analyze mapped network drives
