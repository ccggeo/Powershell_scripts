﻿get-aduser -SearchBase "***" -Filter {enabled -eq $true}  -properties GivenName,  Surname, Title, mail, Department, telephoneNumber, mobile| select GivenName,  Surname, Title, mail, Department, telephoneNumber, mobile | export-csv c:\scripts\freshservice_export_withemails.csv