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
###########################################
# SCRIPT VERSION & EDITS
###########################################
s_build_date='[Thu Aug 13 19:40:02 UTC 2015]'
s_build_update='[Thu Aug 13 19:40:02 UTC 2015]' # Change me, if changes are made
s_org='3M HIS, Cloud Hosting Operations'
s_author='Nicholas M. Houle'; # Add name ", name" when changes are made
s_version='1.0.0'
###########################################
# FUNCTION: is_empty
# DESCRIPTION: Check value is empty 
# Parameters: 
#   $1 = value to check
###########################################
function is_empty() {
  t_param=$1
  t_param="$(echo -e "${t_param}" | xargs)"
  # Check value is not empty and a number
  if [[ -z "${t_param}" ]]; then
      # return 0, is empty
      return 0
  fi
  # return 1, not empty
  return 1
}
###########################################
# Identify P_ROOT
###########################################
#P_ROOT=/home/drainwater/provisioning
#P_ROOT='/extra/t_nhoule/3M/projects/scripts/provisioning'
S_ROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
P_ROOT=$( dirname "$S_ROOT" )
# tail elsearch-kwb-di2-0000* | grep "SSH Access" | awk '{print $4,$5.$6}'
# tail elsearch-kwb-qa-0000* | grep "SSH Access" | awk '{print $4,$5.$6}'
# tail elsearch-kwb-ct-0000* | grep "SSH Access" | awk '{print $4,$5.$6}'
# tail elsearch-kwb-pr-0000* | grep "SSH Access" | awk '{print $4,$5.$6}'
serverfile='servers.cinder'
mapfile -t filecontent < "$serverfile" # Bash4
# Check for epmty server list
if ( is_empty "${serverfile}" ); then
	echo -e "[INFO]: Please specify a server list in the server.cinder file."
	exit 1
fi
###########################################
# SSH
# LOOP Trhough servers.cinder file 
# printf "Instance: %s\n" "${filecontent[@]}"
###########################################
for host in "${filecontent[@]}"; do
#get_time=$(ntpdate -q time.mmm.com | grep ':' | awk '{print $3}')
#echo -e "Get time (time.mmm.com): ${get_time}"
if [[ "${host}" != "" ]]; then

ssh_string="-q -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null nhoule-cho@${host}"

	printf "Instance: %s\n" "${host}"
	echo "$(date)"

	###########################################
	# NLPQ HOST Configuration
	# DESCRIPTION: 
	# This is a requirement for cinder deployments.
	# Create LVM Device Mappers for the host
	# Rackspace='ssh_raxdfw_make_cinder.part'
	# Example: $0 -d [Device] -p [Partition Type] -g [LVM group] -l [LVM Lable] -m [LVM Dev Mapper Name]
	###########################################
	# This is for NLPQ Deployments.
	if [ -f "${P_ROOT}/bin/ssh_raxdfw_make_cinder.part" ]; then
	echo -e "[INFO]: Running LVM partition sub-routine"
	# Using API_NAME, configure host for the DC location.
	ssh ${ssh_string} 'bash /dev/stdin -d vdb -p gpt -g vg2 -l lv_data01 -m /dev/mapper/vg2-lv_data01' < "ssh_raxdfw_make_cinder.part"
	fi

fi
# Check the status of the last command
if [[ ! $? = 0 ]]; then
	echo -e "[ Failed ]"
fi
done