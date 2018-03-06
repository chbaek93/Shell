#!/bin/sh 

# -- By chb@mz.co.kr -- # 
# -- July 24, 2017 -- # 

host1="aurora.cluster"
host2="aurora"
delay=5
user=master

innotop --host $host1 --delay $delay --user $user --password PASSWORD
