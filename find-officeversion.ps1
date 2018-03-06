import-module activedirectory
$c = 

$output= @()
$c | %{ 
    #Creating a new PS-Object 
    $y = New-Object  Psobject  
    $y | Add-Member NoteProperty -Name "ExcelProductVersion" -Value (invoke-command -computername $_ -ScriptBlock {
    $excelPath =  'C:\Program Files (x86)\Microsoft Office\Office15\EXCEL.EXE' 
    $excelProperty = (Get-ItemProperty $excelPath -Filter *) 
    $excelproperty.VersionInfo.ProductVersion 
   })
   $y | add-member noteproperty -name "hostname" -value $_ 

    $output += $y
   }

 $output | FT


