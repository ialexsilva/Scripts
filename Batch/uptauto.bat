@echo off
color 9e
title Uptime for - %1
powershell h:\batch\uptime.ps1 -Computer %1

set /p ques=Press enter to ping

title Pinging - %1
set count=1
:top
PING  -n 1 %1 | FIND "TTL="
IF ERRORLEVEL 1 (SET OUT=4F  & echo Request timed out.) ELSE (SET OUT=9E)
color %OUT%
IF %OUT%==4F (SET /A count=%count%+1 & title Pinging - %1 - %count% Dropped) ELSE (SET OUT=9E)
ping -n 2 -l 10 127.0.0.1 >nul
GoTo top