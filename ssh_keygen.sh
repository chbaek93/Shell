#!/bin/sh

# -- chb@mz.co.kr , Nov 10, 2016

# -- Create a public Key in Bastion EC2 Instance -- #
ssh-keygen -t rsa -b 2048 -v
cat ~/.ssh/id_rsa.pub

# -- And Copy Above Strings -- #
# Paste Public Key at authorized_keys file of ec2-user
cat >> authorized_keys 

# -- Client take the id_rsa Key and Server take the id_rsa.pub -- # 
# -- End of Line -- #
