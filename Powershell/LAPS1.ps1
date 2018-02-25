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



do{
$PCID = Read-Host "PCID?"
$PCID = get-adcomputer $PCID -Property ms-Mcs-AdmPwd
Write-Host
Write-Host $pcid.'ms-Mcs-AdmPwd'
Write-Host
}while($PCID -ne "exit")