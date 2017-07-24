#!/bin/sh

# -- By chb@mz.co.kr -- # 
# -- July 24, 2017 -- # 
DomainName=$1 

if [ ! $DomainName ]; then 
  echo "You need a Domain Name !!"
  exit
fi 

# -- Upload SSL Certification for Domain name -- # 
aws iam upload-server-certificate --server-certificate-name $DomainName \
	--certificate-body file:///tmp/$DomainName.crt --private-key file:///tmp/$DomainName-NoPass.key \
	--certificate-chain file:///tmp/CA_ROOT.crt --path /cloudfront/$DomainName/

# -- End of Line -- # 
