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
# Info, run the ssh-agent in the backgroud
cat <<_ENDOFCAT_

================================
Starting the ssh-agent service
================================
Agent Service: "$(eval $(ssh-agent -s))"

_ENDOFCAT_
# Ensure ssh-agent pid exists
sleep 5

# Info, add the key file to system memory for SSH agent forwarding
echo -e "[INFO]: Add key file to system memory for SSH agent forwarding"
ssh-add