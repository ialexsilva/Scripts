set fso = CreateObject("Scripting.FileSystemObject")
set Shell = WScript.CreateObject("WScript.Shell") 
shell.run "H:\Batch\ReIcon\ReIcon_v1.6\ReIcon.exe /Restore /ID qpj"
shell.run "OUTLOOK.EXE"
shell.run "H:\notes.xlsm"
shell.run "H:\Desktop\OneNote.lnk"
shell.run "H:\Desktop\Slacker.lnk"
shell.run "H:\Desktop\KioskMon.lnk"
shell.run "H:\Desktop\ServiceNow.lnk"

