$Clip =
    {
        add-type -an system.windows.forms
        [System.Windows.Forms.Clipboard]::GetText()
    }


[void] [System.Reflection.Assembly]::LoadWithPartialName("'Microsoft.VisualBasic")
[Microsoft.VisualBasic.Interaction]::AppActivate("blank.txt - Notepad")

[void] [System.Reflection.Assembly]::LoadWithPartialName("'System.Windows.Forms")
[System.Windows.Forms.SendKeys]::SendWait($Clip)