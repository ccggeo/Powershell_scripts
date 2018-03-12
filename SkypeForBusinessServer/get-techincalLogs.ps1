$target = ""
$u = ""
mkdir "c:\temp\sfb\techincallogs\$u"



$items = (get-childitem "\\$target\c$\Users\$u\AppData\Local\Microsoft\Office\16.0\Lync\Tracing" | ? {$_.Extension -Like ".uccapilog"}).name 

$items | % {


Copy-Item "\\$target\c$\Users\$u\AppData\Local\Microsoft\Office\16.0\Lync\Tracing\$_"  "c:\temp\sfb\techincallogs\$u" -verbose 

}