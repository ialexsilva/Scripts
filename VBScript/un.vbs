strComputer = InputBox( PCID )

Set objWMI = GetObject("winmgmts:" _
              & "{impersonationLevel=impersonate}!\\" _
              & strComputer & "\root\cimv2")

Set colSessions = objWMI.ExecQuery _
    ("Select * from Win32_LogonSession Where LogonType = 2 OR LogonType = 10")

For Each objSession in colSessions
     Set colList = objWMI.ExecQuery("Associators of " _
         & "{Win32_LogonSession.LogonId=" & objSession.LogonId & "} " _
         & "Where AssocClass=Win32_LoggedOnUser Role=Dependent" )

     For Each objItem in colList
       WScript.Echo "User: " & objItem.Name
       Next
   Next