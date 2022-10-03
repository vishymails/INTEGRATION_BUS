echo off
  rem ------------------------------------------------------------------------
  rem -- Program: Usertrace Utility 
  rem 
  rem  (c) Copyright IBM Corp. 2003, 2015
  rem US Government Users Restricted Rights - Use duplication or
  rem disclosure restricted by GSA ADP Schedule Contract with IBM Corp
  rem
  rem 
  Rem -- Version: 1.3
  rem -- Updated: 10.15.2015
  rem -- Purpose: start usertrace for a special messageflow (refresh the log)
  rem --          then wait (user can test the messageflow in another window)   
  rem --          then dump the MQSI log to a file and use Notepad to view the results
  rem --          at last usertrace ist turned off again
  rem -- Required parameters are BrokerName, ExecutionGroup and MsgFlow - CASE SENSITIVE !!!
  rem ------------------------------------------------------------------------

  echo ------------------------------------------------------------------------
  echo -- Usertrace Utility process started
  IF "%1" == "" goto BADPARAM
  IF "%2" == "" goto BADPARAM
  IF "%3" == "" goto BADPARAM
  SET TRCLEVEL=%4
  IF "%4" == "" SET TRCLEVEL=normal

:PROCESS
  echo -- Executing command: mqsichangetrace %1 -u -e %2 -f %3 -l %TRCLEVEL% -r
  mqsichangetrace %1 -u -e %2 -f %3 -l %TRCLEVEL%  -r
  echo -- Now test your Messageflow
  pause
  echo -- Executing command: mqsichangetrace %1 -u -e %2 -f %3 -l none 
  mqsichangetrace %1 -u -e %2 -f %3 -l none 
  echo -- Executing command: mqsireadlog %1 -u -e %2 -o %3.xml -f
  mqsireadlog %1 -u -e %2 -o %3.xml -f
  rem ------------------------------------------------------------------------
  rem -- If the target file exists and REPLACE has not been specified then
  rem -- do not overwrite the file.  Report the error and end the process.
  rem ------------------------------------------------------------------------
  IF NOT EXIST %3.xml goto NOFILE
  IF NOT EXIST %3.txt goto OK
  
  del %3.txt
  
:OK
  echo -- Executing command: mqsiformatlog  -i %3.xml -o %3.txt
  mqsiformatlog  -i %3.xml -o %3.txt
  del %3.xml
  rem ------------------------------------------------------------------------
  rem -- Make sure the output file exists before starting notepad
  rem ------------------------------------------------------------------------
  IF NOT EXIST %3.txt goto NOFILE
  echo -- Output stored in file %3.txt
  echo -- Starting the Notepad editor to view the file
  echo -- Suggestion: Turn on word wrap in Notepad to easily view the output
  start notepad %3.txt
  goto FINISH

:NOFILE
  echo -- ERROR !!!
  echo -- The process did not produce any output.  Look for error messages
  echo -- from previous commands.  Check parameters and try again.
  goto SYNTAX

:BADPARAM
  echo -- Purpose: start usertrace for a special messageflow (refresh the log)
  echo --          then wait (user can test the messageflow in another window)   
  echo --          then dump the MQSI log to a file and use Notepad to view the results
  echo --          at last usertrace ist turned off again
:SYNTAX
  echo ------------------------------------------------------------------------
  echo -- Syntax: usertrace [BrokerName] [Execution Group] [Message Flow] [normal ^| debug]
  echo -- Remember, parameters are case sensitive!!!
  echo ------------------------------------------------------------------------

:FINISH
  echo -- Usertrace Utility process finished
  echo ------------------------------------------------------------------------

:END
