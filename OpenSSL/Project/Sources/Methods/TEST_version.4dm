//%attributes = {"invisible":true}
#DECLARE($params : Object)

If ($params=Null:C1517)
	
/*
async calls must be performed in a worker or form
*/
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $OpenSSL : cs:C1710.OpenSSL
	$OpenSSL:=cs:C1710.OpenSSL.new()
	$version:=$OpenSSL.version()
	
	ALERT:C41($version)
	
End if 