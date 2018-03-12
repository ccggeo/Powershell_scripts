$target = ""
$u = ""
mkdir "c:\temp\sfb\techincallogs\$u"



$items = (gci  "\\$target\c$\Users\$u\AppData\Local\Microsoft\Office\16.0\Lync\Tracing" | ? {$_.Extension -Like ".uccapilog"}).name | sort Lastwritetime | select -last 1

$items | % {


Copy-Item "\\$target\c$\Users\$u\AppData\Local\Microsoft\Office\16.0\Lync\Tracing\$_"  "c:\temp\sfb\techincallogs\$u" -verbose 

}