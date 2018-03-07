#!/bin/tcsh

# -- By chb@mz.co.kr -- #
# -- On Feb 26, 2018 -- #


#ansible all -m shell -a "sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.old && sudo sed 's/PasswordAuthentication\ no/PasswordAuthentication\ yes/g' /etc/ssh/sshd_config.old > /etc/ssh/sshd_config && sudo /etc/init.d/sshd restart" --private-key=./my.pem -u ec2-user
#ansible all -m shell -a "sudo cp /etc/cloud/cloud.cfg.d/00_defaults.cfg /etc/cloud/cloud.cfg.d/00_defaults.cfg.old && sudo sed 's/ssh_pwauth:\ false/ssh_pwauth:\ true/g' /etc/cloud/cloud.cfg.d/00_defaults.cfg.old > /etc/cloud/cloud.cfg.d/00_defaults.cfg" --private-key=./my.pem -u ec2-user

ansible all -m shell -a "yum -y install httpd24* && /etc/init.d/httpd start" --private-key=my.pem
