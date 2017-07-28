#!/bin/sh 

# -- By chb@mz.co.kr -- # 
# -- Managing services with systemd : https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/System_Administrators_Guide/chap-Managing_Services_with_systemd.html-- # 

# -- Systemd Unit Files Locations -- # 
# -- /usr/lib/systemd/system/ : Systemd unit files distributed with installed RPM packages -- # 
# -- /run/systemd/system/ : Systemd unit files created at run time. This directory takes precedence over the directory with installed service unit files. -- # 
# -- /etc/systemd/system/ : Systemd unit files created by systemctl enable as well as unit files added for extending a service. -- # 



# sctl=systemctl

systemctl list-units 
systemctl list-units --type=service 
systemctl list-unit-files 

systemctl start name.service 
systemctl stop name.service 
systemctl restart name.service 

# -- Restarts a service only if it is running -- # 
systemctl try-restart name.service 
systemctl reload name.service 
systemctl is-active name.service 

systemctl status name.service 
systemctl is-active name.service 
systemctl is-enabled name.service 
systemctl is-failed name.service 

# -- Displays the status of all services. -- # 
systemctl list-units --type service -all 

# -- 
systemctl mask name.service 
systemctl unmask name.service 

