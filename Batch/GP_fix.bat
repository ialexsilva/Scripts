@echo off
color 9e
:top
cls
echo %date% %time%
C:\Windows\System32\reg.exe import H:\Batch\GP_Fix.reg
echo %date% %time%
h:\batch\sleep 60
goto top