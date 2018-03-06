#!/bin/tcsh 

# -- By chb@mz.co.kr -- # 
# -- On Mar 02, 2018 -- # 

set Profile = 'default'
set Region = 'ap-northeast-2'


aws ec2 describe-instances --profile $Profile --region $Region | jq '.| { Name : .Reservations[].Instances[].Tags[].Value,InstanceId : .Reservations[].Instances[].InstanceId, PublicIp : .Reservations[].Instances[].PrivateIpAddress }'  

