#!/bin/sh 

# -- chb@mz.co.kr -- # 

awk '/httpd/ {print $1,$2}' /etc/passwd
