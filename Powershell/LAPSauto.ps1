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


$PCID = get-adcomputer $args -Property ms-Mcs-AdmPwd
PopUp $pcid