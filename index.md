---
layout: default
---

![version](https://img.shields.io/badge/version-20%2B-E23089)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/OpenSSL)](LICENSE)
![downloads](https://img.shields.io/github/downloads/miyako/OpenSSL/total)

### Licensing

* the source code of this component is licensed under the [MIT license](https://github.com/miyako/curl/blob/master/LICENSE).
* see [openssl-library.org](https://openssl-library.org/source/license/index.html) for the licensing of **OpenSSL**.

# Use OpenSSL from 4D

## Usage

```4d
#DECLARE($params : Object)

If ($params=Null)
    
    /*
        async calls must be performed in a worker or form
    */
    
    CALL WORKER(1; Current method name; {})
    
Else 
    
    var $OpenSSL : cs.OpenSSL.OpenSSL
    $OpenSSL:=cs.OpenSSL.OpenSSL.new()
    
    $key:=Folder(fk desktop folder).file("key.pem")
    $crt:=Folder(fk desktop folder).file("crt.pem")
    
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
```

```4d
var $OpenSSL : cs.OpenSSL
$OpenSSL:=cs.OpenSSL.new()

$key:=Folder(fk desktop folder).file("private.key")
$crt:=Folder(fk desktop folder).file("certificate.crt")
$p12:=Folder(fk desktop folder).file("certificate.p12")

var $worker : 4D.SystemWorker

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

ALERT($worker.response)
```

## Build CLI

* macOS

```
./Configure -no-shared -no-pinshared
```

* Windows ([vcpkg](https://vcpkg.io/en/package/openssl.html))

```
vcpkg install openssl[tools] --triplet x64-windows-static
```
