@echo off
set /p t=Target?
set /p a=Start What?
PsExec.exe \\%t% -u administrator -p Password -i %a%