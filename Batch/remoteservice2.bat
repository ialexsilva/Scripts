@echo off
title Fix Service and Start Reomte Control
color 9E

set /p PCID=PCID?
sc.exe \\%PCID% start CmRcService
sc.exe \\%PCID% config CmRcService start= auto
start "" "C:\Program Files\Microsoft Configuration Manager\AdminConsole\bin\i386\cmrcviewer.exe " %PCID%