##!/bin/bash
#
AWS_CONFIG_FILE=$HOME/.aws/credentials
aws_vpc="vpc-706e9e17"
aws_cli_base="aws --profile pr --output text"
aws_elb_group="${aws_cli_base} ec2 describe-security-groups --query "SecurityGroups[*].GroupId""
aws_group_create="${aws_cli_base} ec2 create-security-group --vpc-id "${aws_vpc}""
aws_group_allow="${aws_cli_base} ec2 authorize-security-group-ingress"
SDLC="PR"
#
###HDD
#t_group_name="${SDLC}-HDD-App"
#t_elb_group=$(${aws_elb_group} --filter Name=group-name,Values="ELB-pr-HDD*")
#t_group_id=$(${aws_group_create} --group-name "${t_group_name}" --description "Security Group for ${t_group_name} Instances")
#${aws_cli_base} ec2 create-tags --resource ${t_group_id} --tags Key=Name,Value="${t_group_name}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 443 --source-group "${t_elb_group}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 22 --source-group "sg-9ce844e7"
#echo "[INFO]  Created Group '${t_group_name}' with ID: ${t_group_id}"
#
#
###NLPQ
#t_group_name="${SDLC}-NLPQ-App"
#t_elb_group=$(${aws_elb_group} --filter Name=group-name,Values="ELB-pr-NLPQ*")
#t_group_id=$(${aws_group_create} --group-name "${t_group_name}" --description "Security Group for ${t_group_name} Instances")
#${aws_cli_base} ec2 create-tags --resource ${t_group_id} --tags Key=Name,Value="${t_group_name}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 443 --source-group "${t_elb_group}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 22 --source-group "sg-9ce844e7"
#echo "[INFO]  Created Group '${t_group_name}' with ID: ${t_group_id}"
#
#
###NLPKWB
#t_group_name="${SDLC}-NLPKWB-App"
#t_group_id=$(${aws_group_create} --group-name "${t_group_name}" --description "Security Group for ${t_group_name} Instances")
#${aws_cli_base} ec2 create-tags --resource ${t_group_id} --tags Key=Name,Value="${t_group_name}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 22 --source-group "sg-9ce844e7"
#echo "[INFO]  Created Group '${t_group_name}' with ID: ${t_group_id}"
#
#
####ELSearch
##t_group_name='QA-ELSEARCH-LOG'
##t_elb_group='sg-e2a16599'
##t_group_id=$(${aws_group_create} --group-name "${t_group_name}" --description "Security Group for ${t_group_name} Instances")
##${aws_cli_base} ec2 create-tags --resource ${t_group_id} --tags Key=Name,Value="${t_group_name}"
##${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 9200 --source-group "${t_elb_group}"
##${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 22 --source-group "sg-9ce844e7" --group-owner "259701781532"
##echo "[INFO]  Created Group '${t_group_name}' with ID: ${t_group_id}"

## Logstash Group
t_group_name='PR-Logstash-App'
t_elb_group='sg-3bc2ea46'
t_group_id=$(${aws_group_create} --group-name "${t_group_name}" --description "Security Group for ${t_group_name} Instances")
${aws_cli_base} ec2 create-tags --resource ${t_group_id} --tags Key=Name,Value="${t_group_name}"
${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 9111-9112 --source-group "${t_elb_group}"
${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 22 --source-group "sg-9ce844e7" --group-owner "259701781532"
${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 8334-8335 --cidr 169.70.71.5/32
${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 8334-8335 --cidr 169.10.10.229/32
${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 8334-8335 --cidr 192.28.32.113/32
echo "[INFO]  Created Group '${t_group_name}' with ID: ${t_group_id}"

