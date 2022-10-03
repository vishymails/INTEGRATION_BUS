@rem -----------------------------------------------------------------------
@echo off
  @rem  Program: GetTrace Utility 
  @rem Version: 1.2
  @rem (c) Copyright IBM Corp. 2003, 2015 
  @rem US Government Users Restricted Rights - Use duplication or
  @rem disclosure restricted by GSA ADP Schedule Contract with IBM Corp
  @rem
  @rem Purpose: start usertrace for an integration server (refresh the log)
  @rem          then wait (user can test the messageflow in another window)   
  @rem Purpose: Dump IBM Integration user trace log to a file and use Notepad to view results
  @rem optional parameters are IntegrationNodeName and IntegrationServerName 
  @rem ------------------------------------------------------------------------
echo off

  SET Broker=IIBNODE_WITHQM
  Set Exegrp=server1
  @IF '%1' NEQ '' SET Broker=%1
  @IF '%2' NEQ '' Set Exegrp=%2



:PROCESS
@echo off
  mqsireadlog %Broker% -u -e %Exegrp% -o %Exegrp%.xml -f
  IF NOT EXIST %Exegrp%.xml goto NOFILE
  IF NOT EXIST %Exegrp%.txt goto OK
  
  del %Exegrp%.txt
  
:OK
  mqsiformatlog  -i %Exegrp%.xml -o %Exegrp%.txt
  del %Exegrp%.xml
  IF NOT EXIST %Exegrp%.txt goto NOFILE
  mqsichangetrace %Broker% -u -e %Exegrp% -r
  start notepad %Exegrp%.txt
  goto FINISH

:NOFILE
  @echo ERROR !!!
  @echo The process did not produce any output.  Look for error messages
  @echo from previous commands.  Check parameters and try again.
  @echo Maybe you forgot to supply parameters [BrokerName] [Execution Group] 
  mqsilist
  mqsilist %Broker%
  goto SYNTAX

:SYNTAX
  @echo ------------------------------------------------------------------------
  @echo Syntax: gettrace [iNodeName] [iServerName] 
  @echo Remember, parameters are case sensitive!!!
  @echo ------------------------------------------------------------------------

:FINISH
  @echo Gettrace Utility process finished
  @echo ------------------------------------------------------------------------

:END
