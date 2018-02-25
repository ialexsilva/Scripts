On Error Resume Next 

ip=InputBox("IP?", "Printer")
name=InputBox("Name?", "Printer")


 
'SETS 'LOAD DRIVER' PRIVILEGE. 
 
 
    Set objWMIService = GetObject("Winmgmts:") 
 
    objWMIService.Security_.Privileges.AddAsString "SeLoadDriverPrivilege", True 
 
 
'SETS PRINTER PORT. 
 
 
    Set objNewPort = objWMIService.Get _ 
        ("Win32_TCPIPPrinterPort").SpawnInstance_ 
 
    objNewPort.Name = ip 
 
    objNewPort.Protocol = 1 
 
    objNewPort.HostAddress = ip
 
    objNewPort.PortNumber = "9100" 
 
    objNewPort.SNMPEnabled = False 
 
    objNewPort.Put_ 
 
 
'SETS PRINTER TO PORT. 
 
 
    Set objPrinter = objWMIService.Get _ 
        ("Win32_Printer").SpawnInstance_ 
 
    objPrinter.DriverName = "Brother HL-1270N" 
 
    objPrinter.PortName   = ip 
 
    objPrinter.DeviceID   = name & " TCP/IP"
 
    objPrinter.Location = "" 
 
    objPrinter.Network = True 
 
    objPrinter.Shared = False 
 
    'objPrinter.ShareName = 
 
    objPrinter.Put_ 
 
 
    next 