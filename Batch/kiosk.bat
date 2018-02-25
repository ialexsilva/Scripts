@echo off
color 9E
title Kiosk Tool

:top
cls
set "kiosk=null"
set "re=null"
set "rb=null"
set /p knum=Kiosk #?

set adatest=false
if "%knum%" == "01" set adatest=true
if "%knum%" == "02" set adatest=true
if "%adatest%" == "true" (set kiosk=SFAD00%knum%) ELSE (set kiosk=SFSK00%knum%)


ping -n 1 %kiosk% | FIND "TTL="
IF ERRORLEVEL 1 (goto down) ELSE (goto up)


:down
cls
echo Unable to ping %kiosk%
echo.
pause
goto top

:up
cls
echo %kiosk% is up
echo.
echo Killing kiosk app
echo.
taskkill /s \\%kiosk% /u %kiosk%\administrator /p Password /im electron.exe /t /f >nul 2>&1
echo Done
echo.
set /p re=Remote to kiosk (y/n)?
if "%re%"=="y" (goto remote)
goto next

:next
echo.
set /p rb=Reboot to kiosk (y/n)?
if "%rb%"=="y" (goto reboot) else (goto top)

:remote
echo.
echo Opening Remote Control
start "" "C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\i386\CmRcViewer.exe" %kiosk%
goto next

:reboot
echo Sending Shutdown
NET USE \\%kiosk%\IPC$ Password /USER:administrator
shutdown /m \\%kiosk% /r /t 1 /f
start h:\Batch\pauto.bat %kiosk%
goto top