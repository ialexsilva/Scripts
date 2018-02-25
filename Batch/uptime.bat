@echo off
color 9e
set /p t=Target?
title Uptime for - %t%
powershell h:\batch\uptime.ps1 -Computer %t%
pause