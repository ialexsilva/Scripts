set Shell = WScript.CreateObject("WScript.Shell") 

PASS = Inputbox("Password?","Input")

Shell.sendkeys "{CLICK LEFT}"
Shell.sendkeys PASS 