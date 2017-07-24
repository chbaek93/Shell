#!/bin/sh 

# -- By chb@mz.co.kr -- # 
# -- July 24, 2017 -- # 

KeyName=$1 

if [ ! $KeyName ]; then 
	echo "We need a Key Name !!"
	echo 
	exit -1
fi 


# -- Create a pem key -- # 
echo "Step #1 : Create a pem Key " 
openssl genrsa -aes256 -out $KeyName.pem 2048

echo 
echo "Step #2 : Create a pem Key with No Password " 
# -- Remove PassPhrase From Key -- # 
openssl rsa -in $KeyName.pem -out $KeyName-nopass.pem 

# -- Create a Public Key from Private Key -- # 
openssl rsa -in $KeyName.pem -pubout > $KeyName.pub

# -- DES-EDE3-CBC -- # 
# openssl genrsa -des3 -out $KeyName.key 2048

# openssl rsa -in $KeyName.key -out $KeyName-nopass.key

## openssl req -new -key $KeyName.key -out $KeyName.csr
