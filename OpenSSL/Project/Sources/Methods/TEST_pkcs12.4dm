//%attributes = {"invisible":true}
var $OpenSSL : cs:C1710.OpenSSL
$OpenSSL:=cs:C1710.OpenSSL.new()

$key:=Folder:C1567(fk desktop folder:K87:19).file("private.key")
$crt:=Folder:C1567(fk desktop folder:K87:19).file("certificate.crt")
$p12:=Folder:C1567(fk desktop folder:K87:19).file("certificate.p12")

var $worker : 4D:C1709.SystemWorker

$worker:=$OpenSSL.start(["req"; \
"-x509"; \
"-newkey"; "rsa:2048"; \
"-nodes"; \
"-keyout"; $key; \
"-out"; $crt; \
"-days"; 365; \
"-subj"; "/C=US/ST=New York/L=New York/O=MyCompany/CN=localhost"]).worker

$worker.wait()
$stdErr:=$worker.responseError  //console messages

$worker:=$OpenSSL.start(["pkcs12"; \
"-export"; \
"-out"; $p12; \
"-inkey"; $key; \
"-in"; $crt; \
"-passout"; "pass:1234"]).worker

$worker.wait()
$stdErr:=$worker.responseError  //console messages

$worker:=$OpenSSL.start(["pkcs12"; \
"-info"; \
"-nokeys"; \
"-in"; $p12; \
"-password"; "pass:1234"]).worker

$worker.wait()

ALERT:C41($worker.response)