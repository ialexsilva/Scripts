@echo off
tasklist /FI "IMAGENAME eq notepad.exe" 2>NUL | find /I "notepad.exe">NUL 
if "%ERRORLEVEL%" == "0" goto end

start notepad.exe

echo 1

:end
echo 2