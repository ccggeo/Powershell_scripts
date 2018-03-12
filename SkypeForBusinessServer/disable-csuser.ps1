
invoke-command -Credential $creds -ComputerName -Authentication Credssp -ScriptBlock {set-csuser -identity -enabled $false 




}
