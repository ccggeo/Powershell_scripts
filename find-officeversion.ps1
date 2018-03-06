import-module activedirectory
$c = 

$output= @()
$c | %{

    $line= '' | Select hostname,excelversion
    #Creating a new PS-Object 
    $y = New-Object  Psobject  
    $x = 
       $y | Add-Member NoteProperty -Name "ExcelProductVersion" -Value (invoke-command -computername $_ -ScriptBlock {
    
    $excelPath =  'C:\Program Files (x86)\Microsoft Office\Office15\EXCEL.EXE' 
    $excelProperty = (Get-ItemProperty $excelPath -Filter *)
    $excelproperty.VersionInfo.ProductVersion 
       #excel 

   })
 
 
    $line.hostname = $_
    $line.excelversion = $y
    $output += $line

}
 $output | FT
#$excelProperty | select-object -Property 

