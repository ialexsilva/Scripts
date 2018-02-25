set Shell = WScript.CreateObject("WScript.Shell") 

Set objHTML = CreateObject("htmlfile")
ClipboardText = objHTML.ParentWindow.ClipboardData.GetData("text")

shell.run "H:\Batch\ls.lnk -u:stationcasinos\" & ClipboardText
shell.run "H:\Batch\PasswordExpireAuto.bat " & ClipboardText
