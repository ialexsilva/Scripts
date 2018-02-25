set Shell = WScript.CreateObject("WScript.Shell") 
shell.run "C:\Windows\Resources\Themes\landscapes.theme"
wscript.sleep(6000) 
shell.run "C:\Windows\Resources\Themes\landscapes.theme"
wscript.sleep(2000)
Shell.appactivate("Personalization")
Shell.sendkeys "%{F4}"
shell.run "H:\Batch\theme.vbs"