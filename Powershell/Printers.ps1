﻿Get-WMIObject -class Win32_Printer -computer stnembosser | Select Name,PortName,Location | Export-CSV -path 'C:\printers.csv'