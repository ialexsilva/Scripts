@echo off
color 9e
title BSINFOCOMP PMS Script

:start
call stopserv.bat BSINFOCOMP PMS_Interface
echo %TIME%
echo Wait 5 mins
echo.
sleep 300
call startserv.bat BSINFOCOMP PMS_Interface
echo %TIME%
echo Wait 10 mins
echo.
sleep 600
goto start