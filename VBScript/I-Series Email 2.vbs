xtime = Inputbox("Time?","Input")
ampm = Inputbox("AM or PM?","Input")

bocpu = Inputbox("FO - CPU?","Input")
gtcpu = Inputbox("GT - CPU?","Input")
glcpu = Inputbox("GL - CPU?","Input")

bodisk = Inputbox("FO - Disk Arm?","Input")
gtdisk = Inputbox("GT - Disk Arm?","Input")
gldisk = Inputbox("GL - Disk Arm?","Input")

boirt = Inputbox("FO - Interactive Resp ?","Input")
gtirt = Inputbox("GT - Interactive Resp ?","Input")
glirt = Inputbox("GL - Interactive Resp ?","Input")

Dim ol, ns, newMail

Set ol = WScript.CreateObject("Outlook.Application")
Set ns = ol.getNamespace("MAPI")
Set newMail = ol.CreateItem(olMailItem)
newMail.Subject = "I-Series Monitoring Update - " & xtime & " " & ampm
newMail.HTMLBody = "<font face=" & Chr(34) & "Calibri" & Chr(34) & ">" & "<b><u>I-Series Monitoring Update</u></b><br><br>" & "<b>FO</b><br><br>As of " & xtime & ":00 " & ampm & "<br>Status - Good<br> " & "CPU - " & bocpu & "% <br>" & "Disk Arm - " & bodisk & "% <br> Interactive Resp -  " & boirt & " seconds <br>" & "<br><b>GT</b><br><br>As of " & xtime & ":00 " & ampm & "<br>Status - Good<br> " & "CPU - " & gtcpu & "% <br>" & "Disk Arm - " & gtdisk & "% <br> Interactive Resp -  " & gtirt & " seconds <br>" &"<br><b>GL</b><br><br>As of " & xtime & ":00 " & ampm & "<br>Status - Good<br> " & "CPU - " & glcpu & "% <br>" & "Disk Arm - " & gldisk & "% <br> Interactive Resp -  " & glirt & " seconds <br>" & "<br>Solution Center has monitored the iSeries System and there have been no issues with CPU, Response Time, or Disk Arm.<br><br><br><br>"
newMail.To = "Hong, Abe; King, Jim; Von Tobel, Jon; Cassone, Leith; Lebo, Matthew; Phelps, Susan; Zobrist, Kristie; Santos, Andrew; Group - I.T. - Support Solutions Center; Zurita, Frank; JCarle; jdevos"
newMail.Display