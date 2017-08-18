#!/bin/sh
## Default Port 514
## @@ TCP, @ UDP
# https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/System_Administrators_Guide/s1-basic_configuration_of_rsyslog.html
# Forwarding to remote machine
# ----------------------------
# *.*	@172.19.2.16		# udp (standard for syslog)
# *.*	@@172.19.2.17		# tcp
#"sudo echo '*.* @@127.0.0.1:1514' >> /etc/rsyslog.conf"
# RSYSLOG_CMD="sudo echo '*.* @@127.0.0.1:1514' >> /etc/rsyslog.conf"
# echo "$RSYSLOG_CMD"