@echo off
set /p PCID=PCID?
set /p PASS=Password (10 Characters)?
C:\Windows\System32\pspasswd.exe \\%PCID% administrator %PASS%
echo.
pause