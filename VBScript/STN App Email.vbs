guest = Inputbox("Guest name","Input")
bp = Inputbox("Boarding Pass number?","Input")
phone = Inputbox("Phone #","Input")
email =  Inputbox("Email","Input")
ca = Inputbox("CA #","Input")

Dim ol, ns, newMail

Set ol = WScript.CreateObject("Outlook.Application")
Set ns = ol.getNamespace("MAPI")
Set newMail = ol.CreateItem(olMailItem)
newMail.Subject = "CA# " & ca & " - STN Mobile Application Login Issue"
newMail.HTMLBody = "Guest called saying they are unable to login to their account. The username and password the guest is using to login is not working. Please Assist<br><br>" & guest & "<br> BP#: " & bp & "<br>" & phone & "<br>" & email & " <br><br><br><br><font size=" & Chr(34) & "4" & Chr(34) & " face=" & Chr(34) & "Segoe Script" & Chr(34) & "><b>Scott Sullivan </b></font>| Solution Center Analyst | Station Casinos<br>1505 South Pavilion Center Drive, Las Vegas, NV 89135<br>Tel: 702-240-4357     Fax: 702-495-3442"""

newMail.To = "MyBoardingPass"
newMail.CC = email & "; Zurita, Frank"
newMail.Display