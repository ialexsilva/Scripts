@echo off
cls
color 1B
echo.
echo.
echo.
echo                   THIS PROCEDURE IS FOR MSMQ TROUBLESHOOTING!
echo.
echo.
echo.
echo.
echo.
echo.
echo                     [Press Ctrl + C to EXIT this program.] 
echo.
echo                                   - OR -
echo.
pause

::PING TEST
cls
color 0E
echo.
echo.
echo.
echo                 TRANMITTING PING TO RRMSMQ...

echo.
ping rrmsmq
echo.
echo.
echo.
echo.
:askPing
CHOICE /C YN /N /M "Was the PING test successful? ( Y  or  N ) : "
IF '%ERRORLEVEL%'=='1' GOTO RDPTEST
IF '%ERRORLEVEL%'=='2' GOTO PINGNO
GOTO eof

:PINGNO
cls
color F4
echo You said the ping test failed
echo.
echo CONTACT SERVER ENGINEER ON-CALL ADVISING THAT "RRMSMQ" DOES NOT RESPOND TO PING.
echo.
echo.
echo End of automated procedure.
pause
GOTO eof

:RDPTEST
cls
color 1b
echo.
echo                  *** REMOTE DESKTOP CONNECTION TEST ***
echo.
echo.
echo You said the ping test was successful.
echo.
echo Next verify you receive a login prompt using Remote Desktop to RRMSMQ.
echo.
echo This will run Remote Desktop to RRMSMQ automatically.
echo.
echo DO NOT ACTUALLY LOGIN!
echo Just verify the login prompt comes up, then select "Cancel".
echo.
echo                     [Press Ctrl + C to EXIT this program.] 
echo.
echo                                   - OR -
echo.
pause
START mstsc /v:rrmsmq
echo.
echo.
echo.
CHOICE /C YN /N /M "Did the Remote Desktop login prompt appear? ( Y  or  N ) : "
IF '%ERRORLEVEL%'=='1' GOTO ServiceRestarts
IF '%ERRORLEVEL%'=='2' GOTO RDPNO
GOTO eof

:RDPNO
cls
color F4
echo You said the Remote Desktop test failed
echo.
echo Wait for THREE minutes then...
echo ...run this program again.
echo.
echo If successful the second time select "Y" at the RDP question.
echo.
echo.
echo If after waiting three minutes and trying again, Remote Desktop still
echo will not prompt for a login to RRMSMQ, or if you receive a message
echo that the workstation is unavailable, then...
echo.
echo CONTACT SERVER ENGINEER ON-CALL ADVISING THAT YOU CANNOT RDP TO "RRMSMQ".
echo.
echo.
echo End of automated procedure.
pause
GOTO eof

:ServiceRestarts
cls
color 2F
echo.
echo                   *** MESSAGE QUEUE SERVICE RESTARTS ***
echo.
echo.
echo You said the Remote Desktop test was successful.
echo.
echo.
echo Next the program will automatically stop and restart message queue services.
echo.
echo.
echo                     [Press Ctrl + C to EXIT this program.] 
echo.
echo                                   - OR -
echo.
pause


cls
color 5F
echo.
echo              *** NOW RUNNING MESSAGE QUEUE SERVICE RESTARTS ***
echo.
echo.
SET SERVER=STNESB03
SET SERVICE="Neuron ESB (Default)"
SET RETURN=ESB3Neur
GOTO restartservice
:ESB3Neur

echo.
echo.
echo.
SET SERVER=STNService5
SET SERVICE="WF Runtime Service"
SET RETURN=Svc5WF
GOTO restartservice
:Svc5WF

echo.
echo.
echo.
SET SERVER=STNService4
SET SERVICE="Station Casinos Workflow Runtime Service"
SET RETURN=Svc4WF
GOTO restartservice
:Svc4WF

echo.
echo.
echo.
SET SERVER=STNCOMMHUBSVC
SET SERVICE="Comm Hub Listener Service"
SET RETURN=CHLS
GOTO restartservice
:CHLS

echo.
echo.
echo.
SET SERVER=STNService5
SET SERVICE="StationCasinos.WindowsService.CmsPinChangeProcessingService"
SET RETURN=Svc5PIN
GOTO restartservice
:Svc5PIN

echo.
echo.
echo.
SET SERVER=STNService5
SET SERVICE="Station Casinos Cms Session Processing Service"
SET RETURN=Svc5SPS
GOTO restartservice
:Svc5SPS

echo.
echo.
echo.
SET SERVER=STNService4
SET SERVICE="Station Casinos Cms Rating Processing Service"
SET RETURN=Svc4RPS
GOTO restartservice
:Svc4RPS

color 2F
echo.
echo.
echo.
echo %TIME%
echo.
echo Message Queue Service Restart Procedure Completed!
echo.
echo You may scroll the screen up to review, or...
echo.
echo.
echo.
echo.
pause

cls
color 1B
echo.
echo                           *** CLEAR SCOM ALERTS ***
echo.
echo.
echo.
echo 1) Go to SCOM and highlight all associated messages.
echo 2) Right-click and choose CLOSE ALERTS.
echo.
echo NOTE: If they reappear shortly thereafter, notify Application Engineer On-Call.
echo.
echo.
echo.
echo.
echo              ******* END OF MSMQ TROUBLESHOOTING PROCEDURE *******
echo.
echo.
pause
GOTO eof



:: -------------------------------------------------------------------
:: Subroutine based on a scripts originally authored by Eric Falsken

:restartservice

echo.
echo.
echo %TIME%
echo %SERVICE% service on %SERVER%

:: STOP SERVICE

ping -n 1 %SERVER% | FIND "TTL=" >NUL
IF errorlevel 1 GOTO SystemOffline
SC \\%SERVER% query %SERVICE% | FIND "STATE" >NUL
IF errorlevel 1 GOTO SystemOffline

:ResolveInitialState
SC \\%SERVER% query %SERVICE% | FIND "STATE" | FIND "RUNNING" >NUL
IF errorlevel 0 IF NOT errorlevel 1 GOTO StopService
SC \\%SERVER% query %SERVICE% | FIND "STATE" | FIND "STOPPED" >NUL
IF errorlevel 0 IF NOT errorlevel 1 GOTO stoppedService
SC \\%SERVER% query %SERVICE% | FIND "STATE" | FIND "PAUSED" >NULL
IF errorlevel 0 IF NOT errorlevel 1 GOTO SystemOffline
echo Service State is changing, waiting for service to resolve its state before making changes
sc \\%SERVER% query %SERVICE% | Find "STATE"
timeout /t 2 /nobreak >NUL
GOTO ResolveInitialState

:StopService
echo Stopping %SERVICE% on \\%SERVER%
sc \\%SERVER% stop %SERVICE% %3 >NUL

GOTO stoppingService
:stoppingServiceDelay
echo Waiting for %SERVICE% to stop
timeout /t 2 /nobreak >NUL
:stoppingService
SC \\%SERVER% query %SERVICE% | FIND "STATE" | FIND "STOPPED" >NUL
IF errorlevel 1 GOTO stoppingServiceDelay

:stoppedService
echo %SERVICE% on \\%SERVER% is stopped

timeout /t 15

::START SERVICE

ping -n 1 %SERVER% | FIND "TTL=" >NUL
IF errorlevel 1 GOTO SystemOffline
SC \\%SERVER% query %SERVICE% | FIND "STATE" >NUL
IF errorlevel 1 GOTO SystemOffline

:ResolveInitialState
SC \\%SERVER% query %SERVICE% | FIND "STATE" | FIND "STOPPED" >NUL
IF errorlevel 0 IF NOT errorlevel 1 GOTO StartService
SC \\%SERVER% query %SERVICE% | FIND "STATE" | FIND "RUNNING" >NUL
IF errorlevel 0 IF NOT errorlevel 1 GOTO StartedService
SC \\%SERVER% query %SERVICE% | FIND "STATE" | FIND "PAUSED" >NULL
IF errorlevel 0 IF NOT errorlevel 1 GOTO SystemOffline
echo Service State is changing, waiting for service to resolve its state before making changes
sc \\%SERVER% query %SERVICE% | Find "STATE"
timeout /t 2 /nobreak >NUL
GOTO ResolveInitialState

:StartService
echo Starting %SERVICE% on \\%SERVER%
sc \\%SERVER% start %SERVICE% >NUL

GOTO StartingService
:StartingServiceDelay
echo Waiting for %SERVICE% to start
timeout /t 2 /nobreak >NUL
:StartingService
SC \\%SERVER% query %SERVICE% | FIND "STATE" | FIND "RUNNING" >NUL
IF errorlevel 1 GOTO StartingServiceDelay

:StartedService
echo %SERVICE% on \\%SERVER% is started
GOTO:%RETURN%


:SystemOffline
echo Server \\%SERVER% or service %SERVICE% is not accessible or is offline
echo Starting Services Manager
start C:\Windows\system32\services.msc /Computer=%SERVER%
GOTO:%RETURN%
:: -------------------------------------------------------------------



:eof


