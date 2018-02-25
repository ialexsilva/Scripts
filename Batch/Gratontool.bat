@echo off
:top
title Graton Ping
color 2F
set /p PCID=Graton PCID?
title Pinging - %PCID%
set "DNS=%PCID%%.CORP.GRATONRESORTCASINO.COM"
echo.
echo DNS Name = %DNS%
set count=1
for /f "skip=1 tokens=2 delims=[]" %%* in (
   'ping.exe -n 1 %DNS%') Do (set "IP=%%*" )
title Pinging - %PCID% - %IP%
echo IP Address = %IP%
echo.
if [%IP%]==[] (goto opps)

set /p ACT=[P]ing or [R]emote?
echo.
if %ACT%==p (goto pingloop)
if %ACT%==r (goto remote)

goto end

:opps
color 4F
echo Somethings wrong, did not get an IP
echo.
pause
cls
goto top

:remote
subst x: /d
subst x: "C:\Program Files\Microsoft Configuration Manager\AdminConsole\bin\i386"
x:\cmrcviewer.exe %IP%
subst x: /d

goto end

:pingloop
PING  -n 1 %IP% | FIND "TTL="
IF ERRORLEVEL 1 (SET OUT=4F  & echo Request timed out.) ELSE (SET OUT=2F)
color %OUT%
IF %OUT%==4F (SET /A count=%count%+1 & title Pinging - %IP% - %IP% - %count% Dropped) ELSE (SET OUT=2F)
ping -n 2 -l 10 127.0.0.1 >nul
GoTo pingloop

:end
pause