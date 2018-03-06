import-module activedirectory
$c = 

$output= @()
$c | %{
invoke-command -computername $_ -ScriptBlock {
    
    $line= '' | Select hostname,excelversion, user
    $dec = (get-adobject  -filter * -identity $_ -Properties *).description
    $excelPath =  'C:\Program Files (x86)\Microsoft Office\Office15\EXCEL.EXE' 

    $excelProperty = Get-ItemProperty $excelPath 
    #Creating a new PS-Object 
    $x = New-Object  Psobject  
    
    #excel 
    $x | Add-Member NoteProperty -Name "ExcelProductVersion" -Value $excelProperty.VersionInfo.ProductVersion 

    $y = $x.ExcelProductVersion

    $line.hostname = hostname
    $line.excelversion = $y
   }

          $line
        $output += $line

}
 $output | FT 
#$excelProperty | select-object -Property 