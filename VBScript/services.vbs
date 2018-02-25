sevr=InputBox("Target?", "Services")
set Shell = WScript.CreateObject("WScript.Shell")
shell.run "C:\Windows\system32\services.msc /Computer=" & sevr