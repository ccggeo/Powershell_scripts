
invoke-command -Credential $creds -ComputerName bs-k-sfb-fe01 -Authentication Credssp -ScriptBlock {set-csuser -identity vhenry -enabled $false 




}