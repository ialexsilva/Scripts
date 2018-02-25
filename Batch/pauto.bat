@echo off
color 9E
title Pinging - %1
set count=1
echo Getting IP
for /f "skip=1 tokens=2 delims=[]" %%* in (
   'ping.exe -n 1 %1') Do (set "IP=%%*" )
title Pinging - %1 - %IP%
:top
PING  -n 1 %1 | FIND "TTL="
IF ERRORLEVEL 1 (SET OUT=4F  & echo Request timed out.) ELSE (SET OUT=9E)
color %OUT%
IF %OUT%==4F (SET /A count=%count%+1 & title Pinging - %1 - %IP% - %count% Dropped) ELSE (SET OUT=9E)
ping -n 2 -l 10 127.0.0.1 >nul
GoTo top
