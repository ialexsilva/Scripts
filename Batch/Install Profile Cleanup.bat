@echo off
set /p pcid=PCID?

copy "H:\Install Files\UPHClean-Setup.msi" "\\%pcid%\c$\"

psexec \\%pcid% -e -s msiexec.exe /i c:\UPHClean-Setup.msi /quiet /qn /norestart

echo 0 and 1030 are good

pause