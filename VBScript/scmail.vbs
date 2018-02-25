canum = Inputbox("CA Number?","Input")
ctime = Inputbox("Time call was received?","Input")
etime = Inputbox("Time Resolved?","Input")
dur = Inputbox("Duration of issue?","Feed Me")
vtm = Inputbox("Verifying TM?","I need input")

Dim ol, ns, newMail

Set ol = WScript.CreateObject("Outlook.Application")
Set ns = ol.getNamespace("MAPI")
Set newMail = ol.CreateItem(olMailItem)
newMail.Subject = "CA#" & canum  & " - Sports Connection Web and Mobile Not Available - Patron Admin Timing Out - RESOLVED"
newMail.HTMLBody = "<b>Time call was received:</b> " & ctime & "<br><b>Brief Description of the issue:</b> Sports Connection was unavailable for wagering, as well as Patron ADMIN timing out.  This is a known issue with SC Web, Mobile and Patron Admin that the development team is aware of and working on a permanent resolution.<br><b>Brief Description of the Resolution Steps:</b> Race & Sports L2 advised to restart the associated WIN service to resolve the current issue. Verified that Sports Connection Web and Mobile open on our test accounts without issue. We also verified that we can access accounts in Patron Admin.<br><b>Time Resolved / Duration of issue:</b> " & etime & " / " & dur & "<br><b>Verifying TM:</b> " & vtm & "<br><br><br>"
newMail.To = "AllI.T; Choudhary, Arun; Rawat, Pankaj; Verma, Narendra"
newMail.cc = "Evely, Carolyn; McCormick, Jason; Manteris, Art"
newMail.Display