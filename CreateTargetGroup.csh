#!/bin/tcsh 

# -- By chb@mz.co.kr -- # 
# -- On Feb 26, 2018 -- # 

set VpcId = 'vpc-xxxxxxxx'
set TargetGroup = ( my-targets my-targets2 ) 
set TargetGroupProtocol = ( HTTP HTTPS )
set TargetGroupPort = ( 80 443 )
set TargetType = 'instance'

foreach i (`seq 1 2`)
    aws elbv2 create-target-group \
        --name $TargetGroup[$i] \
        --protocol $TargetGroupProtocol[$i] \
        --port $TargetGroupPort[$i] \
        --vpc-id $VpcId \
        --target-type $TargetType 
end
