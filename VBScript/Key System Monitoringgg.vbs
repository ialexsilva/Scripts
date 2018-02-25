xtime = Inputbox("Time?","Input")
ampm = Inputbox("AM or PM?","Input")

bocpu = Inputbox("FO - CPU?","Input")
gtcpu = Inputbox("GT - CPU?","Input")

bodisk = Inputbox("FO - Disk Arm?","Input")
gtdisk = Inputbox("GT - Disk Arm?","Input")

boirt = Inputbox("FO - Interactive Resp?","Input")
gtirt = Inputbox("GT - Interactive Resp?","Input")

accolor = Inputbox("AutoCash Color?   Red Yellow or Green","Input")
account = Inputbox("AutoCash Count?","Input")

sqlcpu = Inputbox("Grid Iron Glory SQL CPU%?","Input")
sqlcon = Inputbox("Grid Iron Glory SQL Connections?","Input")

psqlcpu = Inputbox("Promotions SQL CPU%?","Input")
psqlcon = Inputbox("Promotions SQL Connections?","Input")

Dim ol, ns, newMail

Set ol = WScript.CreateObject("Outlook.Application")
Set ns = ol.getNamespace("MAPI")
Set newMail = ol.CreateItem(olMailItem)
newMail.Subject = "Key System Monitoring - " & DateValue(CStr(Now())) & " " & xtime & ":00 " & UCase(ampm)
newMail.HTMLBody = "<font face=" & Chr(34) & "Calibri" & Chr(34) & ">" & "<b><u>I-Series Systems</u></b><br><br>" & "<b>FO</b><br><br>As of " & xtime & ":00 " & ampm & "<br>Status - Good<br> " & "CPU - " & bocpu & "% <br>" & "Disk Arm - " & bodisk & "% <br> Interactive Resp -  " & boirt & " seconds <br>" & "<br><b>GT</b><br><br>As of " & xtime & ":00 " & ampm & "<br>Status - Good<br> " & "CPU - " & gtcpu & "% <br>" & "Disk Arm - " & gtdisk & "% <br> Interactive Resp -  " & gtirt & " seconds <br>" & "<br><br>Solution Center has monitored the iSeries System and there have been no issues with CPU, Response Time, or Disk Arm.<br><br><b><u>Marketing Kiosk v3</u></b><br><br>INSERTMARKETINGALLTOPSCREENSHOTHERE<br><br>INSERTMARKETINGV3TOPSCREENSHOTHERE<br><br>INSERTREDANDYELLOKIOSKSSCREENSHOTHERE<br><br><b><u>AutoCash Error</u></b> -  " & accolor & " - " & account & "<br><br><b><u>Grid Iron Glory</u></b><br>ST7SQLENT03 - No SCOM Errors<br>SQL CPU% - " & sqlcpu & "<br>SQL Connections - " & sqlcon & "<br><br><b><u>Promotions</u></b><br>STNENT01 - No SCOM Errors<br>SQL CPU% - " & psqlcpu & "<br>SQL Connections - " & psqlcon
newMail.To = "GroupITKeySystemsMonitoring"
newMail.Display