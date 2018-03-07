#!/bin/tcsh 

# -- By chb@mz.co.kr -- # 
# -- On Mar 5, 2018 -- # 


set CertificateName = 'mydomain.com'
set Profile = 'default' 
set Region = 'ap-northeast-2' 

# -- Deletes the specified server certificate -- # 
aws iam delete-server-certificate \
  --server-certificate-name $CertificateName \
  --profile $Profile --region $Region 

# -- Lists the server certificates stored in IAM that have the specified path prefix -- # 
aws iam list-server-certificates --profile $Profile --region $Region 
