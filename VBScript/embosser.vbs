set Shell = WScript.CreateObject("WScript.Shell") 
Msgbox "Error on Print Manager - 1380735"
Shell.appactivate("Print Management")
Shell.SendKeys "% r"