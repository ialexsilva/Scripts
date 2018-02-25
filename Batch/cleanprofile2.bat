@echo off
color 9E
title Profile Cleanup

IF [%2] == [] goto :end

tasklist /FI "IMAGENAME eq CmRcViewer.exe" 2>NUL | find /I "CmRcViewer.exe">NUL 
if "%ERRORLEVEL%" == "0" goto next

start C:\"Program Files"\"Microsoft Configuration Manager"\"AdminConsole"\"bin"\"i386"\cmrcviewer.exe %1

:next

net use W: /delete /y
net use W: "\\%1\c$\Documents and Settings"

W:

SET dirname=%date:~6,4%-%date:~0,2%-%date:~3,2%
mkdir "%dirname%"

For /D %%G IN (%2*) DO move "%%G" "%dirname%"

H:

echo.
net use W: /delete /y

start C:\Windows\explorer.exe "\\%1\c$\Documents and Settings\"

:end