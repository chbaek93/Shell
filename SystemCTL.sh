#!/bin/sh 

# -- By chb@mz.co.kr -- # 
# -- Managing services with systemd : https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/System_Administrators_Guide/chap-Managing_Services_with_systemd.html-- # 

# -- Systemd Unit Files Locations -- # 
# -- /usr/lib/systemd/system/ : Systemd unit files distributed with installed RPM packages -- # 
# -- /run/systemd/system/ : Systemd unit files created at run time. This directory takes precedence over the directory with installed service unit files. -- # 
# -- /etc/systemd/system/ : Systemd unit files created by systemctl enable as well as unit files added for extending a service. -- # 

# -- 0 : Shut down and power off the system -- # 
# -- 1 : Set up a rescue shell -- # 
# -- 2 : Set up a non-graphical multi-user system. -- # 
# -- 3 : Set up a non-graphical multi-user system. -- # 
# -- 4 : Set up a non-graphical multi-user system. -- # 
# -- 5 : Set up a graphical multi-user system. -- # 
# -- 6 : Shut down and reboot the system -- # 

# sctl=systemctl

systemctl get-default 

systemctl set-default name.target 
systemctl isolate name.target 

# -- EX 
systemctl set-default multi-user.target 
systemctl isolate multi-user.target 
systemctl --no-wall rescue 

systemctl rescue # -- Changing to Rescue Mode -- # 
systemctl emergency 
systemctl --no-wall emergency 


systemctl list-units 
systemctl list-units --type=service 
systemctl list-unit-files 

systemctl start name.service 
systemctl stop name.service 
systemctl restart name.service 
systemctl disable name.service 

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

# -- 
systemctl enable name.service 
systemctl disable name.service 
systemctl status name.service 
systemctl list-unit-files --type service 
systemctl list-dependencies --after httpd.service 
systemctl list-dependencies --before httpd.service 

# -- Shutting Down the System -- # 

systemctl poweroff 
systemctl halt 
systemctl --no-wall poweroff 
shutdown --poweroff hh:mm 

shutdown --halt +m 
shutdown -c # -- Canceled by the root user -- # 
systemctl reboot 
systemctl suspend 
systemctl hibernate
systemctl hybrid-sleep 

# -- Controlling systemd on a remote machine -- # 
systemctl -H root@server-01.example.com status httpd.service 

# -- Create unit file -- # 
touch /etc/systemd/system/name.service 
chmod 664 /etc/systemd/system/name.service 

# -- Unit File : name.service -- # 
[Unit]
Description=service_description
After=network.target

[Service]
ExecStart=path_to_executable
Type=forking
PIDFile=path_to_pidfile

[Install]

systemctl daemon-reload 
systemctl start name.service 


WantedBy=default.target


