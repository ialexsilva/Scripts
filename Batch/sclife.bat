@echo off
color 9e
set /p pcid=PCID?

copy "sclife.reg" "\\%pcid%\c$\"

psexec \\%pcid% -e -s regedit /s c:\sclife.reg

echo.
echo Error Code 0 is Good
echo.

pause