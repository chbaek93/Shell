#!/bin/tcsh

# -- By chb@mz.co.kr -- # 
# -- On Feb 26, 2018 -- # 

set GroupName = 'Dev-EG'
set Protocol = 'tcp'
set Port = '80'
set Cidr = '10.10.10.10/24'
set SourceGroup = 'Dev-SG'
set AccountNo = `aws ec2 describe-security-groups --group-name default   --query  'SecurityGroups[0].[OwnerId]' --output text`

aws ec2 authorize-security-group-ingress --group-name $GroupName --protocol $Protocol --port $Port --cidr $Cidr


aws ec2 authorize-security-group-ingress --group-name $GroupName --protocol $Protocol --port $Port --source-group $SourceGroup --group-owner $AccountNo
