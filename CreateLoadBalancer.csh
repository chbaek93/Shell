#!/bin/tcsh

# -- By chb@mz.co.kr -- # 
# -- On Feb 26, 2018 -- # 

set LoadBalancer = ( myloadbalancer )
set Subnets = ( subnet-xxx subnet-xxx )
set SecurityGroups = ( sg-xxx  sg-xxx ) 
set Scheme = 'internal'

# -- Create a Load Balancer -- # 
set LoadBalancerArn = `aws elbv2 create-load-balancer --name $LoadBalancer[1] --subnets $Subnets --scheme $Scheme --security-groups $SecurityGroups | jq -r '.LoadBalancers[].LoadBalancerArn'`


set Protocol = 'http'
set Port = '8099'
set Actions = ''
set Certificate = 'amazone.or.kr' 
set Actions = 'forward'

# -- Create a Listener -- # 
aws elbv2 create-listener \
        --load-balancer-arn $LoadBalancerArn \
        --protocol $Protocol \
        --port $Port \
        --default-actions $Actions \
        --certificates $Certificate 
