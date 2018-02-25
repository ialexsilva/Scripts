xtime = Inputbox("Time?","Input")
ampm = Inputbox("AM or PM?","Input")
cpu = Inputbox("CPU?","Input")
disk = Inputbox("Disk Arm?","Input")
irt = Inputbox("Interactive Resp ?","Input")

Dim ol, ns, newMail

Set ol = WScript.CreateObject("Outlook.Application")
Set ns = ol.getNamespace("MAPI")
Set newMail = ol.CreateItem(olMailItem)
newMail.Subject = "I-Series Monitoring Update - " & xtime & " " & ampm
newMail.HTMLBody = "<font face=" & Chr(34) & "Calibri" & Chr(34) & ">" & "As of " & xtime & ":00 " & ampm & "<br>Status - Good<br> " & "CPU - " & cpu & "% <br>" & "Disk Arm - " & disk & "% <br> Interactive Resp -  " & irt & " seconds <br>" & "<br> Solution Center has monitored the iSeries System and there have been no issues with CPU, Response Time, and Disk Arm.<br><br>" & "<font size=" & Chr(34) & "4" & Chr(34) & " face=" & Chr(34) & "Segoe Script" & Chr(34) & "><b>Scott Sullivan </b></font>| Solution Center Analyst | Station Casinos<br>1505 South Pavilion Center Drive, Las Vegas, NV 89135<br>Tel: 702-240-4357     Fax: 702-495-3442""" 
newMail.To = "Hong, Abe; King, Jim; Von Tobel, Jon; Phelps, Susan; Zobrist, Kristie; Group - I.T. - Support Solutions Center"
newMail.Display