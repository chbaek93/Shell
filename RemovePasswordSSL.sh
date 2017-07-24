#!/bin/sh 

# -- You must input password in stdout -- # 

openssl rsa -in SSL.key -out SSL-nopass.key
