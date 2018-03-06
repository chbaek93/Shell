#!/bin/tcsh 

# -- By chb@mz.co.kr -- # 
# -- On,In,At Mar 6, 2018 -- # 

# -- Comments : selection Name Tag -- # 

set Region = 'ap-northeast-2'
set Profile = 'default'

aws ec2 describe-instances --profile $Profile --region $Region | jq '.Reservations[].Instances[].Tags[] | select(.Key == "Name")'
