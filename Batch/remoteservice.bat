sc.exe \\%1 start CmRcService
start "" "C:\Program Files\Microsoft Configuration Manager\AdminConsole\bin\i386\cmrcviewer.exe " %1
sc.exe \\%1 config CmRcService start= auto