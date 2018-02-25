@echo off
set /p t=Target?
set /p a=Kill What?
taskkill /S %t% /IM %a% /F
pause