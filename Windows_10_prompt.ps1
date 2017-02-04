#launch admin powershell.

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

#launch window prompt to start installation.
function windows10 {
Add-Type -AssemblyName System.Windows.Forms

$Form = New-Object system.Windows.Forms.Form
$Form.Text = "Hello <username> its time for your Windows 10 upgrade"
$Form.TopMost = $true
$Form.Width = 542
$Form.Height = 330

$button2 = New-Object system.windows.Forms.Button
$button2.Text = "Click here to Start Upgrade"
$button2.Width = 109
$button2.Height = 40
$button2.Add_Click({

#<Path to extracted setup.exe from unarchived windows10 ISO> ensure to add switches to automate /auto /unattend /force 
})
$button2.location = new-object system.drawing.point(203,106)
$button2.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($button2)

$button2 = New-Object system.windows.Forms.Button
$button2.Text = "Start Upgrade"
$button2.Width = 109
$button2.Height = 40
$button2.Add_Click({
})
$button2.location = new-object system.drawing.point(203,106)
$button2.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($button2)

[void]$Form.ShowDialog()
$Form.Dispose()}

windows10