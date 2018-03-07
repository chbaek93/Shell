#!/bin/tcsh 

# -- By chb@mz.co.kr -- # 
# -- On Jan 24, 2018 -- # 
set Region = 'ap-northeast-2'
set Profile = 'default'

set ImportId = `aws ec2 import-image --description "CentOS 6.7" --disk-containers file://containers.json --profile $Profile --region $Region | jq -r '.ImportTaskId' `

aws ec2 describe-import-image-tasks --import-task-ids $ImportId --profile $Profile --region $Region

