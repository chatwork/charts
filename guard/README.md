## Dowlonad guard

https://appscode.com/products/guard/

## create credentials for values.yaml

create server certification

```
# set guard data dir
$ export GUARD_DATA_DIR=$(pwd)

# create ca
$ guard init ca

# create server key
$ openssl genrsa 2048 > pki/server.key

# create server csr
$ openssl req -new -key pki/server.key -out pki/server.csr -subj '/C=JP/ST=Tokyo/L=Minato-ku/O=test/CN=server'

# create server crt
$ openssl x509 -req -in pki/server.csr -CA pki/ca.crt -CAkey pki/ca.key -CAcreateserial -out pki/server.crt -days 3560 -sha256 -extensions SAN -extfile server-v3.txt
```
