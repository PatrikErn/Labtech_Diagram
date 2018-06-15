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
