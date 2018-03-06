#!/bin/tcsh 

# -- By chb@mz.co.kr -- # 
# -- On,In,At Mar 01, 2018 -- # 

set Region = 'ap-northeast-2'
set Profile = 'default'
set RoleName = 'Ec2Role' 

set Insts = ( `aws ec2 describe-instances --profile $Profile --region $Region | jq -r '.Reservations[].Instances[].InstanceId'`)

foreach i ( $Insts )
	echo $i
	aws ec2 associate-iam-instance-profile --instance-id $i --iam-instance-profile Name=$RoleName  --region $Region --profile $Profile
end
