strComputer = InputBox("Target?", "Remote Run")
strCommand = InputBox("Run What?", "Remote Run")

Const INTERVAL = "n"
Const MINUTES = 1

Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Set objScheduledJob = objWMIService.Get("Win32_ScheduledJob")
Set objSWbemDateTime = CreateObject("WbemScripting.SWbemDateTime")

objSWbemDateTime.SetVarDate(DateAdd(INTERVAL, MINUTES, Now()))
errReturn = objScheduledJob.Create(strCommand, objSWbemDateTime.Value, False, 0, 0, True, intJobID)

If errReturn = 0 Then
Wscript.Echo "It Worked!: " & objSWbemDateTime
Else
Wscript.Echo "Shit! Error: " & errReturn
End If