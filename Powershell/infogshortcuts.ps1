$serverlist = Import-Csv H:\Batch\infog.csv
$WshShell = New-Object -comObject WScript.Shell
$serverlist | ForEach-Object {
    $Shortcut = $WshShell.CreateShortcut("H:\batch\InfoGen\" + $_.name + ".lnk")
    $Shortcut.TargetPath = "C:\Windows\System32\services.msc"
    $Shortcut.Arguments = "/Computer=" + $_.server
    $Shortcut.Save()
}