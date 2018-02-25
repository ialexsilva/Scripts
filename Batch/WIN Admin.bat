@echo off

REG ADD "HKCU\Software\Microsoft\Command Processor" /V DisableUNCCheck /T REG_DWORD /F /D 1

echo WIN Administrator is launching - you may close this window.

CMD /C "C:\Program Files\Station Casinos\WIN09\Admin\WIN.Host.App.exe" -l C:\WINAdmin.log+

exit