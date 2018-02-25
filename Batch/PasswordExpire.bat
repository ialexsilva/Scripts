@echo off
set /p UN=Username?
echo.
net user %UN% /domain | FIND "Password"
echo.
pause