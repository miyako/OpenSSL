## Update

- `2026-03-12` [OpenSSL 3.6.1](https://github.com/openssl/openssl/releases/tag/openssl-3.6.1)

## Build static CLI

* macOS

```
./Configure -no-shared -no-pinshared
```

* Windows ([vcpkg](https://vcpkg.io/en/package/openssl.html))

```
vcpkg install openssl[tools] --triplet x64-windows-static
```
