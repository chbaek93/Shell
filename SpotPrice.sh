#!/bin/sh 

# -- By chb@mz.co.kr -- # 
# -- July 24, 2017 -- # 

Type=$1

if [ ! $Type ]; then 
  echo "You need a instance type !!"
  exit 
fi 

aws ec2 describe-spot-price-history --instance-types $Type \ 
--start-time 2017-07-10T11:00:10 --end-time 2017-07-10T12:00:00 \
| grep "Time\|Spot"

# -- End of Line -- # 
