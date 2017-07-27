#!/bin/sh 

# -- chb@mz.co.kr -- # 

awk '/httpd/ {print $0}' /etc/passwd | cut -d: -f2 


