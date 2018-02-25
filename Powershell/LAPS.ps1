# Scott's LAPS tool version 2 
# Setup window and load AD Module

$host.ui.RawUI.WindowTitle = "Scott's LAPS Tool" 
$host.ui.RawUI.ForegroundColor = "White"

$width = 62
$sizeWindow = new-object System.Management.Automation.Host.Size $width,16
$sizeBuffer = new-object System.Management.Automation.Host.Size $width,9999
if ($Host.UI.RawUI.WindowSize.width -gt $width) {
$Host.UI.RawUI.WindowSize = $sizeWindow
$Host.UI.RawUI.BufferSize = $sizeBuffer
}
else {
$Host.UI.RawUI.BufferSize = $sizeBuffer
$Host.UI.RawUI.WindowSize = $sizeWindow
}

if (-not (Get-Module ActiveDirectory)){     
 Import-Module ActiveDirectory -ErrorAction Stop
} 

# Setup Function

function PopUp ($pcid)
{
Add-Type -Assembly PresentationFramework
$window = New-Object Windows.Window
$window.Title = “Scott's LAPS Tool”
$label = New-Object Windows.Controls.Label
$label.Content, $label.FontSize = $pcid.'ms-Mcs-AdmPwd', 125
$window.Content = $label
$window.SizeToContent = “WidthAndHeight”
$null = $window.ShowDialog()   
}

# Loop

do{
$PCID = Read-Host "PCID?"
try{
$PCID = get-adcomputer $PCID -Property ms-Mcs-AdmPwd
}
catch{
Write-Host "Unable to find PC in AD" -ForegroundColor Red
Continue
}
if ($pcid.'ms-Mcs-AdmPwd' -eq $null){
Write-Host "PC not setup for LAPS" -ForegroundColor Red
Continue
}
$pcid.'ms-Mcs-AdmPwd' | clip.exe
PopUp $pcid
}while($PCID -ne "exit")