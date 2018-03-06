#!/bin/tcsh 

# -- By chb@mz.co.kr -- # 
# -- ING ...... 

set Instances = ( Prd-Web-01 Prd-Web-02) 
set AmiId = 'ami-xxxxxxxxxx'
set InstanceType = ( t2.medium t2.medium ) 
set KeyName = ( chb74 )
set Sgs = ( Prd-Mz-Web Prd-Mz-Was )
set Sns = ( Prd-Mz-Web-A Prd-Mz-Was-A ) 

set VpcId = 'vpc-xxxxxxxx'

# -- set InstanceId = `aws ec2 run-instances --image-id $AmiId --count $Count --instance-type $InstanceType --key-name $KeyName --security-group-ids $SgId --subnet-id $SnId --block-device-mappings file://mapping.json`

foreach Sg ( $Sgs )
# -- set Sgn = `aws ec2 describe-security-groups --filters Name=group-name,Values='$Sg' | jq '.SecurityGroups.GroupId'`
    set SgId = `aws ec2 describe-security-groups --filters Name=tag-value,Values=$Sg | jq -r '.SecurityGroups[].GroupId'`
    echo $SgId 
    foreach Sn ( $Sns )
        set SnId = `aws ec2 describe-subnets --filters Name=tag-value,Values=$Sn | jq -r '.Subnets[].SubnetId'`
        echo $SnId
    end 
end
