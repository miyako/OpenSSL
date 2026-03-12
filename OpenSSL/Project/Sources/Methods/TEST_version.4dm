//%attributes = {"invisible":true}
var $OpenSSL : cs:C1710.OpenSSL
$OpenSSL:=cs:C1710.OpenSSL.new()

var $version : Text
$version:=$OpenSSL.version()

ALERT:C41($version)