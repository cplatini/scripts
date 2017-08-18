#!/bin/bash
##########################################################
# Make default: It's possible to invoke this script with command-line arguments.
#
#    Example: ./make_default.sh -a [API_NAME] -h [HOST_NAME] -z [AVAIL_ZONE] -e [ENV_NAME] -s [VM_TYPE]
#
# Environment Details (TESTING)
# Updated: Wed Oct  7 21:01:21 UTC 2015
# This is for testing only please delete any VMs you create.
#
# IMPORTANT: 
# Append a 't-' to any hostname for easy lookup and deletion
# Example: t-nhoule-vm-00001
# Please check your local log directory and clean up any logs 
# to help avoid pushing any logs to git repos.
##########################################################
# TESTING Rackspace API
# TESTING make Deployment script
##########################################################
#./make_default.sh -a raxdfw -h t-nhoule-vm-00001 -z AZ-NP-STANDARD-1 -e DI2 -s NLPD  &>testing-out/t-nhoule-vm-00001.out &

##########################################################
# TESTING Sungard API
# TESTING make Deployment script
##########################################################
#./make_default.sh -a sgden1 -h t-nhoule-vm-20001 -z az-aurora-01 -e SGDI -s NLPD  &>testing-out/t-nhoule-vm-20001.out &


