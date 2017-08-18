#!/bin/bash
###########################################
# DEBUGGING
###########################################
# /bin/sh (usually is a sybolic link to bash)
# /usr/bin/bash
# /usr/bin/env bash
# Debugging: set -x
# set -x   # Print a trace of simple commands and their arguments
###########################################
# SCRIPT INFORMATION
###########################################
# tail nlpr-di2-00* | grep "SSH Access" | awk '{print $4,$5.$6}'
# tail nlpr-qa-00* | grep "SSH Access" | awk '{print $4,$5.$6}'
# tail nlpr-ct-00* | grep "SSH Access" | awk '{print $4,$5.$6}'
# tail nlpr-pr-00* | grep "SSH Access" | awk '{print $4,$5.$6}'
# echo -e "$(/sbin/ifconfig)"
serverfile='servers.txt'
mapfile -t filecontent < "$serverfile"  # Bash4
#printf "Instance: %s\n" "${filecontent[@]}"
for host in "${filecontent[@]}"; do
#get_time=$(ntpdate -q time.mmm.com | grep ':' | awk '{print $3}')
#echo -e "Get time (time.mmm.com): ${get_time}"
if [[ "${host}" != "" ]]; then

printf "Instance: %s\n" "${host}"
echo "$(date)"

ssh -q -o 'StrictHostKeyChecking no' -o 'UserKnownHostsFile /dev/null' nhoule-cho@${host} 'bash -s' <<"__ENDSSH__"
	echo -e "$(hostname) \t[ OK ]"
__ENDSSH__

fi
# Check the status of the last command
if [[ ! $? = 0 ]]; then
	echo -e "[ Failed ]"
fi
done