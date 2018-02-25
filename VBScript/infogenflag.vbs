set Shell = WScript.CreateObject("WScript.Shell") 
shell.run "taskkill /F /IM poswin32.exe"
wscript.sleep(2000)
shell.run "CmosSurvFlag.exe"
wscript.sleep(2000)
Shell.sendkeys "1~"
wscript.sleep(2000)
shell.run "c:\infogenesis\pos_exe\poswin32.exe"