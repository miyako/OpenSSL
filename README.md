# OpenSSL

based on [OpenSSL](https://www.openssl.org)

## dependencies.json

 ```json
{
	"dependencies": {
		"OpenSSL": {
			"github": "miyako/OpenSSL",
			"version": "*"
		}
	}
}
```

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
	$cnf:=File("/RESOURCES/ssl/openssl.cnf")
	
	$OpenSSL.start([\
	"req"; "-x509"; \
	"-newkey"; "rsa:4096"; \
	"-keyout"; $key; \
	"-out"; $crt; \
	"-sha256"; \
	"-days"; 3650; \
	"-nodes"; \
	"-subj"; "\"/C=XX/ST=StateName/L=CityName/O=CompanyName/OU=CompanySectionName/CN=CommonNameOrHostname\""; \
	"-config"; $cnf])
	
End if 
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
