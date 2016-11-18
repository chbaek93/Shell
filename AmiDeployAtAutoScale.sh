#!/bin/bash

# -- chb@mz.co.kr , Nov 10, 2016
# -- 
ServerType=${1:?" ==> usage:  ${0} WEB|WAS"}

set -x
DeployLog=/tmp/deploy-$(date +%Y%m%d\ %H%M%S).log
echo "$AutoScaleName :$AmiId" > $DeployLog

ServerTagValue=Staging-${ServerType^^}
AutoScaleName=Prod-${ServerType,,}-AutoScaleGroup

ServerTagName=Purpose
AsgTagName=aws:autoscaling:groupName

# -- Get AZ Name & Region Name -- #
AZ=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
Region="ap-northeast-2"

# -- Get Server's IP Address -- #
Results=`aws ec2 describe-instances  --filter Name=tag:${ServerTagName},Values=${ServerTagValue} --query 'Reservations[].Instances[].[InstanceId]' --output text | sort -u`
echo -e "\n${ServerTagValue} Server IDs"
for  each_item in ${Results[@]//\"}
do
        InstaceID=${each_item}
        break
done
echo InstaceID  = ${InstaceID}

# -- Create a New AMI. -- #
ImageName=${ServerTagValue}_$(date +%y%m%d-%H%M)
AmiId=$(aws ec2 create-image --instance-id ${InstaceID} --no-reboot --name $ImageName --description "Golden Image for ${ServerType^^} Server" --output text)

# -- Attach a Tag For New AMI -- #
aws ec2 create-tags  --resources $AmiId --tags Key=Name,Value="${ServerType^^} Server Image"

# -- Get Instance ID -- #
InstanceID=$(aws ec2 describe-instances  --filter Name=instance-state-name,Values=running Name=tag:${AsgTagName},Values=${AutoScalename} --query 'Reservations[].Instances[].[InstanceId]' --output text | awk 'NR==1{print $1}')
LaunchConfigName=LC-$ImageName

# -- Create a New Launch Configuration -- #
aws autoscaling create-launch-configuration \
      --launch-configuration-name ${LaunchConfigName} \
      --image-id $AmiId \
      --instance-id $InstanceID \
      --instance-monitoring Enabled=true

# -- Update a New Launch Configuration -- #
aws autoscaling update-auto-scaling-group \
      --auto-scaling-group-name ${AutoScalename} \
      --launch-configuration-name ${LaunchConfigName}

# --  Remove Old Launch Configuration -- #
OldLaunchConfig=`aws autoscaling describe-launch-configurations --query 'LaunchConfigurations[].[LaunchConfigurationName]' --output text | grep $(date +%y%m%d -d "15 day ago")`
for  old_lc in ${OldLaunchConfig[@]//\"}
do
                aws autoscaling delete-launch-configuration --launch-configuration-name ${old_lc}
done

# -- Update a New Desired Value (Current Value * 2) -- #
OldDesire=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names $AutoScaleName --query AutoScalingGroups[].DesiredCapacity --output text)
NewDesire=$(($OldDesire*2))
aws autoscaling set-desired-capacity  --auto-scaling-group-name $AuthScaleName --desired-capacity $NEW_DESIRED

# -- -- #
ElbName=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names  $AutoScaleName --query 'AutoScalingGroups[].LoadBalancerNames'  --output text)
for  elb in ${ElbName[@]//\"}
do
    echo "$(aws elb describe-instance-health --load-balancer-name $elb --output text | sort -u)"
    echo ""
done

OldDate=$(date +%Y%m%d\ %H:%M:%S)

# -- Decrease a Desire Value of Auto Scaling -- #
# -- Check "InService" State of New Deploy Instance -- #
# -- If InService, End while loop -- #
ExitFlag=0
while :
do
    AutoScaleName=$(cut -d: -f1 $DeployLog)
    AmiId=$(cut -d: -f2 $DeployLog)
    AutoScalingDesire=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names $AutoScaleName --query AutoScalingGroups[].DesiredCapacity --output text)
    for instID in `aws ec2 describe-instances --filters "Name=image-id,Values=$AmiId" | grep "InstanceId" | cut -d\" -f4`
    do
        status=$(aws elb describe-instance-health --load-balancer-name real-web-elb --instances $instID | grep "State" | cut -d\" -f4)
        if [ $status == "InService" ]; then
            if [ "$OldDesire" -eq "$AutoScalingDesire" ]; then
                ExitFlag=1
                break
            else 
                if [ "$OldDesire" -lt "$AutoScalingDesire"]; then
                    let autoScalingDesired=autoScalingDesired-1
                    aws autoscaling set-desired-capacity  --auto-scaling-group-name $AutoScaleName --desired-capacity $AutoScalingDesire
                else
                    ExitFlag=1
                    break
                fi
            fi
        fi
    done
    if [ "$ExitFlag" -eq 1 ]; then
        break
    fi

    sleep 10
done

NewDate=$(date +%Y%m%d\ %H:%M:%S)
echo
echo $OldDate
echo $NewDate

# -- End of Code (Deployment)-- #
