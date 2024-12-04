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
	
	var $key; $crt : 4D:C1709.File
	$key:=Folder:C1567(fk desktop folder:K87:19).file("key.pem")
	$crt:=Folder:C1567(fk desktop folder:K87:19).file("crt.pem")
	
	$OpenSSL.start([\
		"req"; "-x509"; \
		"-newkey"; "rsa:4096"; \
		"-keyout"; $key; \
		"-out"; $crt; \
		"-sha256"; \
		"-days"; 3650; \
		"-nodes"; \
		"-subj"; "\"/C=XX/ST=StateName/L=CityName/O=CompanyName/OU=CompanySectionName/CN=CommonNameOrHostname\""])
	
End if 