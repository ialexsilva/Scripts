@echo off
:start
set /p UN=Username?
echo.
net user %UN% /domain | FIND "Password"
echo.
goto start