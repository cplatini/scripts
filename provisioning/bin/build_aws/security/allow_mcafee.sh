#!/bin/bash
#
# Script to allow inbound McAfee to a specified security group
#
# Author:
#  Richard DeHaven 
#
# Version: 0.0.1
# Date: 2016-10-27

aws_acct=$1
secgroup_id=$2

AWS_CONFIG_FILE=$HOME/.aws/credentials
aws_cli_base="aws --profile ${aws_acct} --output text"
aws_group_allow="${aws_cli_base} ec2 authorize-security-group-ingress"

${aws_group_allow} --group-id "${secgroup_id}" --protocol tcp --port 8334-8335 --cidr 169.70.71.5/32
${aws_group_allow} --group-id "${secgroup_id}" --protocol tcp --port 8334-8335 --cidr 169.10.10.229/32
${aws_group_allow} --group-id "${secgroup_id}" --protocol tcp --port 8334-8335 --cidr 192.28.32.113/32

echo "[INFO]  Updated Group ID: ${secgroup_id} with McAfee Rules"
